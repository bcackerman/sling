class AddLengthToClips < ActiveRecord::Migration
  def change
    add_column :clips, :length, :integer
  end
end
