class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
    	t.string :asset
    	t.references :action

      t.timestamps
    end

  end
end
