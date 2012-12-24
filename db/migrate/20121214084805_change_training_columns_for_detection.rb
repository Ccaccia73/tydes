class ChangeTrainingColumnsForDetection < ActiveRecord::Migration
  def up
  	rename_column 	:detections, :trainingset, :positive_training
  	add_column		:detections, :negative_training, :text, :limit => 4096
  end

  def down
  	rename_column	:detections, :positive_training, :trainingset
  	remove_column	:detections, :negative_training
  	#remove_column	:detections, :positive_training
  end
end
