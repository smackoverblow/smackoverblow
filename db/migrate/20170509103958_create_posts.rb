class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.text :title
      t.text :content
      t.references :user, foreign_key: true
      t.integer :votes, default: 0
      t.string :post_type, default: "q"
      t.integer :answered, default: nil

      t.timestamps
    end
    add_index :posts, [:user_id, :created_at]
  end
end
