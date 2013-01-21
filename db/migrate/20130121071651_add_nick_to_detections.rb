class AddNickToDetections < ActiveRecord::Migration
  def change
    add_column :detections, :nickname, :string
  end
end
