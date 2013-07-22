class CreateClips < ActiveRecord::Migration
  def change
    create_table :clips do |t|
      t.string :name
      t.string :file
      t.string :shortlink
      t.integer :user_id

      t.timestamps
    end
    add_index :clips, :name
    add_index :clips, :user_id
  end
end
