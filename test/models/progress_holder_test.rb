# == Schema Information
#
# Table name: progress_holders
#
#  id              :bigint           not null, primary key
#  task_ref        :string
#  live_preview_id :integer
#  user_id         :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require "test_helper"

class ProgressHolderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
