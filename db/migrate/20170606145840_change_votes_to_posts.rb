class ChangeVotesToPosts < ActiveRecord::Migration[5.0]
  def change
    change_table :posts do |t|
      t.rename :votes, :votes_up
      t.references :votes_up
      t.references :votes_down
    end
  end
end
