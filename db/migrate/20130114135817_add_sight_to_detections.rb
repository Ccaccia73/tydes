class AddSightToDetections < ActiveRecord::Migration
  def change
    add_column :detections, :sight, :integer
  end
end
