class AddPasswordDigestToArtists < ActiveRecord::Migration[5.2]
  def change
    add_column :artists, :password_digest, :string
  end
end
