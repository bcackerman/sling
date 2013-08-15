class AddPubsDrinksJoinTable < ActiveRecord::Migration
  def change
    create_table :pubs_drinks, :id => false do |t|
      t.integer   :pub_id
      t.integer   :drink_id
      t.integer   :price

      t.timestamps
    end
  end
end
