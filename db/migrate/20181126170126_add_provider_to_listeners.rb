class AddProviderToListeners < ActiveRecord::Migration[5.2]
  def change
    add_column :listeners, :provider, :string
    add_column :listeners, :uid, :string
  end
end
