class RemoveColumnsFromTrainingNegatives < ActiveRecord::Migration
  def up
  	remove_column :negatives, :detections
  	remove_column :negatives, :positives
  end

  def down
  	add_column :negatives, :detections, :int
  	add_column :negatives, :positives, :int
  end
end
