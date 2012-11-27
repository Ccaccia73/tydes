class AddIndexToDetectionsCode < ActiveRecord::Migration
  def change
  	add_index :detections, :code, unique: true
  end
end
