class SdRenderJob < ApplicationJob
  queue_as :default

  def perform(render_settings, user_id)
    original_prompt = render_settings.delete(:original_prompt)
    style_template = render_settings.delete(:style_template)

    config = RStableDiffusionAI::Configuration.new
    config.host = ENV['SD_API_HOST']
    config.scheme = ENV['SD_API_SCHEME']
    config.debugging = true

    client = RStableDiffusionAI::ApiClient.new(config)

    api_instance = RStableDiffusionAI::DefaultApi.new(client)

    result = api_instance.text2imgapi_sdapi_v1_txt2img_post(render_settings)

  end
end
