class AddMusicToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :music, :string
  end
end
