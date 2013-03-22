class AddCuurEvalIdToDetection < ActiveRecord::Migration
  def change
  	add_column :detections, :currId, :integer
  end
end
