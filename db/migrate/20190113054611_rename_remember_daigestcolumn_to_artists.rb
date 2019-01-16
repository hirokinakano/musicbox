class RenameRememberDaigestcolumnToArtists < ActiveRecord::Migration[5.2]
  def change
    rename_column :artists, :remember_daigest, :remember_digest
  end
end
