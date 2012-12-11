class AddTrainingsetToDetection < ActiveRecord::Migration
  def change
    add_column :detections, :trainingset, :text, :limit => 4096
  end
end
