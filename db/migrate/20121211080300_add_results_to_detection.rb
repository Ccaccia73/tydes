class AddResultsToDetection < ActiveRecord::Migration
  def change
    add_column :detections, :fn, :integer
    add_column :detections, :fp, :integer
    add_column :detections, :tn, :integer
    add_column :detections, :tp, :integer
  end
end
