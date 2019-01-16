class AddRememberDigestToArtists < ActiveRecord::Migration[5.2]
  def change
    add_column :artists, :remember_daigest, :string
  end
end
