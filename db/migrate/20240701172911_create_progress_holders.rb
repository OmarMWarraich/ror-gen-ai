class CreateProgressHolders < ActiveRecord::Migration[7.1]
  def change
    create_table :progress_holders do |t|
      t.string :task_ref
      t.integer :live_preview_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :progress_holders, :task_ref, unique: true
  end
end
