class AddImpressionToClips < ActiveRecord::Migration
  def change
    add_column :clips, :impressions_count, :integer, :default => 0
  end
end
