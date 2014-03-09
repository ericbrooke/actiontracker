class AddAssetToActions < ActiveRecord::Migration
  def change
    add_column :actions, :asset, :string
  end
end
