class AddStripeCustomerRefToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :stripe_customer_ref, :string
    add_index :users, :stripe_customer_ref, unique: true
  end
end
