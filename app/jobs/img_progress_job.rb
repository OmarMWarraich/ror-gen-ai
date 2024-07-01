class ImgProgressJob < ApplicationJob
  queue_as :default

  def perform(task_id, user_id, original_prompt, style_template)
    payload = {
      "id_task": task_id,
      "id_live_preview": 1
    }

    config = RStableDiffusionAI::Configuration.new
    config.host = ENV['SD_API_HOST']
    config.scheme = ENV['SD_API_SCHEME']
    config.debugging = true

    client = RStableDiffusionAI::ApiClient.new(config)

    api_instance = RStableDiffusionAI::DefaultApi.new(client)

    loop do
      sleep 5
      result = api_instance.progressapi_internal_progress_post(payload)

      Rails.logger.debug "Progress: #{result}"
      break if result.completed == true
    end
  end
end
