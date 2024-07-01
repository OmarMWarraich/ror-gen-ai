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
require "test_helper"

class ProgressHolderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
