class ChangeAcceptedTypeToBooleanForPosts < ActiveRecord::Migration[5.0]
  def change
    change_column :posts, :accepted, :boolean, default: false
  end
end
