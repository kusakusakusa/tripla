class CreateFollowings < ActiveRecord::Migration[7.0]
  def change
    create_table :followings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :follower, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :followings, [:user_id, :follower_id], unique: true
  end
end
