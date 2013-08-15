class ReviseSpeeches < ActiveRecord::Migration
  def change
    change_column :speeches,  :delivered_by,    :string,  :default => ""
    change_column :speeches,  :objective,       :string,  :default => ""
  end
end
