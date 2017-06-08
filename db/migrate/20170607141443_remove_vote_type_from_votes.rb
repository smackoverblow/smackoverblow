class RemoveVoteTypeFromVotes < ActiveRecord::Migration[5.0]
  def change
    remove_column :votes, :vote_type
  end
end
