class AddUserIdToActions < ActiveRecord::Migration
  def change
    add_reference :actions, :user, index: true
  end
end
