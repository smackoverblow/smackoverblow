class DeleteVotesUpFromPosts < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :votes_up
  end
end
