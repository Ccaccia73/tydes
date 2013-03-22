class AddTrainingsetToDetection < ActiveRecord::Migration
  def change
    add_column :detections, :trainingset, :text
  end
end
