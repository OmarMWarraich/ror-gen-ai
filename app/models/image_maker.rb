class ImageMaker
  include ActiveModel::Model

  attr_accessor :prompt, :negative_prompt, :sd_model, :batch_size, :steps, :cfg_scale
  attr_accessor :vae, :sampler_name, :seed, :width, :height, :random_seed, :aspect_ratio

  def initialize(attributes = {})
    # Default values
    @prompt          = attributes[:prompt]          || ''
    @negative_prompt = attributes[:negative_prompt] || ''
    @sd_model        = attributes[:sd_model]        || 'BigGAN-512'
    @batch_size      = attributes[:batch_size]      || 1
    @steps           = attributes[:steps]           || 20
    @cfg_scale       = attributes[:cfg_scale]       || 7.5
    @vae             = attributes[:vae]             || 'default_vae'
    @sampler_name    = attributes[:sampler_name]    || 'Euler '
    @seed            = attributes[:seed]            || -1
    @width           = attributes[:width]           || 512
    @height          = attributes[:height]          || 512
    @random_seed     = attributes[:random_seed]     || 1
    @aspect_ratio    = attributes[:aspect_ratio]    || '1:1'

    super(attributes)
  end
end
