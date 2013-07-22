class ChangeInfoFormatInDrinks < ActiveRecord::Migration
  def change
    change_column :drinks, :info1, :text, :limit => nil
    change_column :drinks, :info2, :text, :limit => nil
    change_column :drinks, :info3, :text, :limit => nil
    change_column :drinks, :info4, :text, :limit => nil
    change_column :drinks, :info5, :text, :limit => nil
  end
end
