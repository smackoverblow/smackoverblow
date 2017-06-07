class DeleteVoteColumnsFromPosts < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :votes_up_id, :boolean
    remove_column :posts, :votes_down_id, :boolean
  end
end
