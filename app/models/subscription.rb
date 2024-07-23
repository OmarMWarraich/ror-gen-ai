# == Schema Information
#
# Table name: subscriptions
#
#  id                      :bigint           not null, primary key
#  next_invoice_on         :datetime
#  paid_until              :datetime
#  status                  :string
#  stripe_customer_ref     :string
#  stripe_subscription_ref :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  user_id                 :bigint           not null
#
# Indexes
#
#  index_subscriptions_on_stripe_subscription_ref  (stripe_subscription_ref) UNIQUE
#  index_subscriptions_on_user_id                  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Subscription < ApplicationRecord
  belongs_to :user
end
