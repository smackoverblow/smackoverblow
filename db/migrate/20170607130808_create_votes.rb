class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :vote_type
      t.integer :voter_id

      t.timestamps
    end
    add_index :votes, [:voter_id], unique: true
  end
end
