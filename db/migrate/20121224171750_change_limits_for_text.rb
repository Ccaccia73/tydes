class ChangeLimitsForText < ActiveRecord::Migration
  def up
  	remove_column	:detections, :positive_training
  	remove_column	:detections, :negative_training
  	remove_column	:detections, :value
  	add_column		:detections, :negative_training, :text
  	add_column		:detections, :positive_trainingset, :text
  	add_column		:detections, :value, :text
  end

  def down
  	remove_column	:detections, :positive_training
  	remove_column	:detections, :negative_training
  	remove_column	:detections, :value
  	add_column		:detections, :negative_training, :text, :limit => 4096
  	add_column		:detections, :positive_trainingset, :text, :limit => 4096
  	add_column		:detections, :value, :text, :limit => 4096
  end
end
