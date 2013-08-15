class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|

      t.string    "name"
      t.string    "description"
      t.string    "location"
      t.string    "address"
      t.string    "contact"
      t.string    "website"

      t.string    "status"
      t.boolean   "active"
      t.integer   "credit"
      t.datetime  "joined"
      t.datetime  "certified"

      t.timestamps
    end
  end
end
