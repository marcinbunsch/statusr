class Friends < ActiveRecord::Migration
  def self.up
    create_table "friends", :force => true do |t|
      t.column :user_id, :integer
      t.column :friend_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table "friends"
  end
end
