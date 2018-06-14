class CreateDownloads < ActiveRecord::Migration[5.1]
  def change
    create_table :downloads do |t|
      t.integer :post_id, null: false
      t.integer :user_id, null: false
      t.jsonb :metadata, null: false
      t.timestamps
    end
  end
end
