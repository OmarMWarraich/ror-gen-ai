# == Schema Information
#
# Table name: users
#
#  id                  :bigint           not null, primary key
#  email               :string
#  password_digest     :string
#  stripe_customer_ref :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_users_on_stripe_customer_ref  (stripe_customer_ref) UNIQUE
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
