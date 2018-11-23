class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :content
      t.references :artist, foreign_key: true

      t.timestamps
    end
    add_index :posts, [:artist_id, :created_at]
  end
end
