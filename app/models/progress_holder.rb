# == Schema Information
#
# Table name: progress_holders
#
#  id              :bigint           not null, primary key
#  task_ref        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  live_preview_id :integer
#  user_id         :bigint           not null
#
# Indexes
#
#  index_progress_holders_on_task_ref  (task_ref) UNIQUE
#  index_progress_holders_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class ProgressHolder < ApplicationRecord
  include ActionView::RecordIdentifier
  belongs_to :user

  def broadcast_updated(user_id, task_ref, original_prompt, style_template, result)
    progress_holder = ProgressHolder.find_or_create_by(task_ref:) do |ph|
      ph.user_id = user_id
      ph.live_preview_id = result.progress.positive? ? result.id_live_preview : -1
    end

    user = User.find(user_id)

    # Broadcast the updated progress to the user
    broadcast_update_to(
      "#{dom_id(user)}_main_image",
      partial: "txt2_imgs/loading_progress",
      locals: {
        scroll_to: true,
        original_prompt:,
        style_template:,
        result: JSON.parse(result.to_json)
      },
      target: "image_maker"
    )

  end
end
