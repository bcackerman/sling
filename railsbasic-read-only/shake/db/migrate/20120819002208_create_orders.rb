class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer   :user_id
      t.integer   :pub_id
      t.integer   :drink_id

      t.integer   :price
      t.string    :status

      t.timestamps
    end
  end
end
