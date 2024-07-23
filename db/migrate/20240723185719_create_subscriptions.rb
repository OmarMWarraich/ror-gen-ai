class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.string :stripe_customer_ref
      t.string :stripe_subscription_ref
      t.datetime :next_invoice_on
      t.datetime :paid_until
      t.references :user, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
    add_index :subscriptions, :stripe_subscription_ref, unique: true
  end
end
