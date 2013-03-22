class RemoveColumnsFromTrainingPositives < ActiveRecord::Migration
  def up
  	remove_column :positives, :trainings
  	remove_column :positives, :detections
  	remove_column :positives, :positives
  end

  def down
  	add_column :positives, :trainings, :int
  	add_column :positives, :detections, :int
  	add_column :positives, :positives, :int
  end
end
