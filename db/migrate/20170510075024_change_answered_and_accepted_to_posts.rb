class ChangeAnsweredAndAcceptedToPosts < ActiveRecord::Migration[5.0]
  def change
    change_table :posts do |t|
      t.references :answered
      t.references :accepted
    end
  end
end
