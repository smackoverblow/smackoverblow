class AddPostIdToVotes < ActiveRecord::Migration[5.0]
  def change
    add_column :votes, :post_id, :integer
  end
end
