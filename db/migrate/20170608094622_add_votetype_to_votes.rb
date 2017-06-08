class AddVotetypeToVotes < ActiveRecord::Migration[5.0]
  def change
    add_column :votes, :vote_type, :integer
  end
end
