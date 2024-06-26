class Txt2ImgsController < ApplicationController
  def index
    api_instance = RStableDiffusionAI::DefaultApi.new
    result = api_instance.get_sd_models_sdapi_v1_sd_models_get
    @models = result.map { |model| model.model_name }
  end

  def create

  end
end
