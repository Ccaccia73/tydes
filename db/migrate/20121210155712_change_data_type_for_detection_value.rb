class ChangeDataTypeForDetectionValue < ActiveRecord::Migration
  def up
  	change_column :detections, :value, :text
  end

  def down
  	change_column :detections, :value, :string
  end
end
