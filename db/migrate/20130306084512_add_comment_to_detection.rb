class AddCommentToDetection < ActiveRecord::Migration
  def change
    add_column :detections, :comment, :text
  end
end
