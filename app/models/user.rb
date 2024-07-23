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
class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true

  normalizes :email, with: ->(email) { email.strip.downcase }

  has_many :generated_images, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  generates_token_for :password_reset, expires_in: 10.minutes do
    password_salt&.last(10)
  end
end
