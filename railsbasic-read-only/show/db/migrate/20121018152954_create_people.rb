class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.integer  "user_id"

      t.string   "name"
      t.integer  "age"
      t.string   "avatar"
      
      t.timestamps
    end
  end
end
