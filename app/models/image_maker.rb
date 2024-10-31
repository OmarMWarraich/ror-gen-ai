# hold the image creation for the form
class ImageMaker
  include ActiveModel::Model

  attr_accessor :prompt, :negative_prompt, :sd_model, :steps, :seed, :random_seed
  attr_accessor :width, :height, :sampler_name, :style_template, :aspect_ratio

  def initialize(params = {})
    @prompt = params[:prompt] || ""
    @negative_prompt = params[:negative_prompt] || ""
    @sd_model = params[:sd_model] || "dall-e"
    @steps = params[:steps] || 32
    @seed = params[:seed] || -1
    @random_seed = params[:random_seed] || true
    @width = params[:width] || 512
    @height = params[:height] || 512
    @sampler_name = params[:sampler_name] || "Euler"
    @style_template = params[:style_template] || "default"
    @aspect_ratio = params[:aspect_ratio] || "1:1" #square
  end
end
