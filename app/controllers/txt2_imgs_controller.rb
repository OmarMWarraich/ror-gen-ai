class Txt2ImgsController < ApplicationController
  def index

    @styles = Styles.load

    api_instance = RStableDiffusionAI::DefaultApi.new
    result = api_instance.get_sd_models_sdapi_v1_sd_models_get
    @models = result.map { |model| model.model_name }
  end

  def create
    style = Styles.find_by_name(params[:style_template])
    style = { name: '++ None', prompt: '{prompt}', negative_prompt: '' } if style.nil?

    prompt = params[:prompt]
    merged_prompt = style[:prompt].gsub('{prompt}', prompt)
    merged_negative_prompt = [style[:negative_prompt], image_maker_params[:negative_prompt]].compact.join(', ')

    sd_settings = {
      original_prompt: image_create_params[:prompt],
      prompt: merged_prompt,
      negative_prompt: merged_negative_prompt,
      sampler_name: 'DPM++ 2M Karras',
      override_settings: { sd_model_checkpoint: image_create_params.delete(:sd_model) }
  }.deep_symbolize_keys

  new_settings = image_create_params.to_h.deep_symbolize_keys.merge(sd_settings)
  end

  private

  def image_create_params
    params.require(:image_maker).permit(:prompt, :style_template)
  end
end
