class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer  "user_id"
      t.integer  "post_id"
      t.integer  "link_id"

      t.integer  "overall",       :default => 0
      t.integer  "purpose",       :default => 0
      t.integer  "organization",  :default => 0
      t.integer  "body",          :default => 0
      t.integer  "voice",         :default => 0
      t.integer  "humor",         :default => 0
      t.integer  "value",         :default => 0
      t.integer  "power",         :default => 0

      t.timestamps
    end
  end
end
