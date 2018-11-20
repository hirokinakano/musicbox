class AddColumnsToListeners < ActiveRecord::Migration[5.2]
  def change
    add_column :listeners, :name, :string
  end
end
