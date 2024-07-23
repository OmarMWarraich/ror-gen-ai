# == Schema Information
#
# Table name: generated_images
#
#  id              :bigint           not null, primary key
#  info            :json
#  negative_prompt :string
#  parameters      :json
#  prompt          :string
#  style_template  :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_generated_images_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class GeneratedImage < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :user
  has_one_attached :sketch

  after_create_commit { broadcast_created }

  def broadcast_created
    broadcast_to_main_image

    broadcast_to_gallery
  end

  def broadcast_to_main_image
    broadcast_update_to(
      "#{dom_id(user)}_main_image",
      partial: "generated_images/display_main_image",
      locals: {
        scroll_to: true,
        generated_image: self
      },
      target: "image_maker"
    )
  end

  def broadcast_to_gallery
    broadcast_prepend_to(
      "#{dom_id(user)}_gallery",
      partial: "/txt2_imgs/gallery",
      locals: {
        scroll_to: true,
        gallery: self
      },
      target: "main_gallery"
    )
  end

  def self.create_from_sd_render_job(render_settings, user_id, result)
    user = User.find(user_id)
    result.images.each do |src_image|
      generated_image = user.generated_images.create(
        prompt: render_settings[:original_prompt],
        negative_prompt: render_settings[:negative_prompt],
        style_template: render_settings[:style_template],
        parameters: result.parameters,
        info: result.info,
        sketch: {
          io: StringIO.new(Base64.decode64(src_image)),
          content_type: 'image/png',
          filename: "#{render_settings[:original_prompt]}-#{SecureRandom.uuid}.png".last(256)
        }
      )
    end
  end
end
