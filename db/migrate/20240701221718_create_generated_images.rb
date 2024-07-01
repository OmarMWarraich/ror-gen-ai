class CreateGeneratedImages < ActiveRecord::Migration[7.1]
  def change
    create_table :generated_images do |t|
      t.string :prompt
      t.string :negative_prompt
      t.string :style_template
      t.references :user, null: false, foreign_key: true
      t.json :info
      t.json :parameters

      t.timestamps
    end
  end
end
