class ImgProgressJob < ApplicationJob
  queue_as :default

  def perform(task_id, user_id, original_prompt, style_template)
    payload = {
      "id_task": task_id,
      "id_live_preview": 1
    }

    config = RStableDiffusionAI::Configuration.new
    config.host = ENV.fetch('SD_API_HOST')
    config.scheme = ENV.fetch('SD_API_SCHEME')
    config.debugging = true

    client = RStableDiffusionAI::ApiClient.new(config)

    api_instance = RStableDiffusionAI::DefaultApi.new(client)

    start_time = Time.now

    loop do
      sleep 5
      result = api_instance.progressapi_internal_progress_post(payload)

      Rails.logger.debug "Progress: #{result}"
      break if result.completed == true

      Rails.logger.debug "Time.now - start_time: #{Time.now - start_time}"

      break if Time.now - start_time > 240

      ProgressHolder.new.broadcast_updated(user_id, task_id, original_prompt, style_template, result)
    end
  end
end
