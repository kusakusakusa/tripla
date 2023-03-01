class CreateSleepLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :sleep_logs do |t|
      t.datetime :wake_up_at
      t.references :user, null: false, foreign_key: true, index: true

      t.datetime :created_at, index: true
      t.datetime :updated_at
    end
  end
end
