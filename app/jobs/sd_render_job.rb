class SdRenderJob < ApplicationJob
  queue_as :default

  def perform(render_settings, user_id)

    config = RStableDiffusionAI::Configuration.new
    config.host = ENV['SD_API_HOST']
    config.scheme = ENV['SD_API_SCHEME']
    config.debugging = true

    client = RStableDiffusionAI::ApiClient.new(config)

    api_instance = RStableDiffusionAI::DefaultApi.new(client)

    our_task_id = "task(#{rand(36**5...36**6).to_s(36)}#{rand(36**5...36**6).to_s(36)}#{rand(36**5...36**6).to_s(36)})"

    render_settings[:task_id] = our_task_id
    render_settings[:id_task] = our_task_id

    ImgProgressJob.perform_later(our_task_id, user_id, render_settings[:original_prompt], render_settings[:style_template])

    result = api_instance.text2imgapi_sdapi_v1_txt2img_post(render_settings.except(:original_prompt, :style_template))

    GeneratedImage.create_from_sd_render_job(render_settings, user_id, result)

    result
  end
end
