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
  belongs_to :user
  has_one_attached :sketch
end
