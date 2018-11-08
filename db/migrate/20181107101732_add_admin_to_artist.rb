class AddAdminToArtist < ActiveRecord::Migration[5.2]
  def change
    add_column :artists, :admin, :boolean, default: false
  end
end
