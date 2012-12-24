class ChangeLimitForDetectionValue < ActiveRecord::Migration
  def up
  	#:tablename, :fieldname, :text, :limit => nil
  	change_column :detections, :value, :text
  end

  def down
  	change_column :detections, :value, :text
  end
end
