class Txt2ImgsController < ApplicationController
  before_action :authenticate_user!

  def index

    @styles = Styles.load

    config = RStableDiffusionAI::Configuration.new
    config.host = ENV['SD_API_HOST']
    config.scheme = ENV['SD_API_SCHEME']
    config.timeout = 15
    # config.debugging = true

    client = RStableDiffusionAI::ApiClient.new(config)

    begin
      api_instance = RStableDiffusionAI::DefaultApi.new(client)
      result = api_instance.get_sd_models_sdapi_v1_sd_models_get
      @models = result.map { |model| model.model_name }
    rescue StandardError
      Rails.logger.error "failed to get models"
      @models = []
    end

    @gallery = current_user.generated_images.order(created_at: :desc).limit(30)
  end

  def create
    style = Styles.find_by_name(image_create_params[:style_template])
    style ||= { name: 'default', prompt: '{prompt}', negative_prompt: '' }

    prompt = image_create_params[:prompt]
    merged_prompt = style[:prompt].gsub('{prompt}', prompt)
    merged_negative_prompt = [style[:negative_prompt], image_create_params[:negative_prompt]].compact.join(', ')

    aspect_ratios = {
      '3:2' => { height: 682, width: 1024 },
      '1:1' => { height: 1024, width: 1024 },
      '2:3' => { height: 1024, width: 682 }
    }

    height, width = aspect_ratios.fetch(image_create_params[:aspect_ratio], { height: 1024, width: 1024 }).values_at(:height,
                                                                                                                :width)

    sd_settings = {
      original_prompt: image_create_params[:prompt],
      style_template: image_create_params[:style_template],
      prompt: merged_prompt,
      negative_prompt: merged_negative_prompt,
      sampler_name: 'DPM++ 2M Karras',
      width: width,
      height: height,
      steps: image_create_params[:steps],
      override_settings: { sd_model_checkpoint: image_create_params.delete(:sd_model) }
  }.deep_symbolize_keys

  Rails.logger.info("sd_settings: #{sd_settings}")
  # new_settings = image_create_params.to_h.deep_symbolize_keys.merge(sd_settings)
  render_result = SdRenderJob.perform_now(sd_settings, current_user.id)

  respond_to do |format|
    format.turbo_stream do
      render turbo_stream: turbo_stream.replace(
        'process_starting',
        partial: '/txt2_imgs/process_starting'
      )
    end
  end
  end

  private

  def image_create_params
    params.require(:image_maker).permit(:style_template, :prompt, :negative_prompt, :sd_model, :aspect_ratio, :steps)
  end
end
