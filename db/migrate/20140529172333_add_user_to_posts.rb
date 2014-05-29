class AddUserToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :user_id, :integer
    #this was part of the checkpoint, adding the following:
    add_index :posts, :user_id
  end
end
