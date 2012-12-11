class ChangeLimitForDetectionValue < ActiveRecord::Migration
  def up
  	#:tablename, :fieldname, :text, :limit => nil
  	change_column :detections, :value, :text, :limit => 4096
  end

  def down
  	change_column :detections, :value, :text, :limit => 255
  end
end
