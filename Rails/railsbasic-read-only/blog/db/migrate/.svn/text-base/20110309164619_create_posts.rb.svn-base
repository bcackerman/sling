class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.text :entry
      t.binary :voice
      t.string :lang
      t.integer :view
      t.integer :like
      t.timestamp :created_at
      t.integer :topic_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
