class CreatePubs < ActiveRecord::Migration
  def change
    create_table :pubs do |t|
      t.string    :name
      t.string    :address
      t.string    :city
      t.string    :state
      t.float     :latitude
      t.float     :longitude
      t.string    :phone
      t.string    :website

      t.string    :event
      t.string    :special
      
      t.string    :logo
      t.string    :info1
      t.string    :info2
      t.string    :info3
      t.string    :info4
      t.string    :info5
      t.string    :photo1
      t.string    :photo2
      t.string    :photo3
      t.string    :photo4
      t.string    :photo5
      t.string    :caption1
      t.string    :caption2
      t.string    :caption3
      t.string    :caption4
      t.string    :caption5

      t.timestamps
    end
  end
end
