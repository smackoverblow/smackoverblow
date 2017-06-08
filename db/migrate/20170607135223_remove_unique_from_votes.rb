class RemoveUniqueFromVotes < ActiveRecord::Migration[5.0]
  def change
    remove_index :votes, :voter_id
  end
end
