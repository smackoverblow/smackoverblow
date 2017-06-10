class ChangeAcceptedAndAnsweredForPosts < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :accepted
    remove_column :posts, :accepted_id
    change_table :posts do |t|
      t.references :accepted
    end
  end
end
