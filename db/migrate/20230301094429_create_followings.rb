class CreateFollowings < ActiveRecord::Migration[7.0]
  def change
    create_table :followings do |t|
      t.references :user, null: false, foreign_key: true, index: false
      t.references :friend, null: false, foreign_key: { to_table: :users }, index: false

      t.timestamps
    end

    add_index :followings, [:user_id, :friend_id], unique: true
  end
end
