class AddScreenshotToClips < ActiveRecord::Migration
  def change
    add_column :clips, :screenshot, :string
  end
end
