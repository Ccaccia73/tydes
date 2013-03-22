class AddCodeToDetections < ActiveRecord::Migration
  def change
    add_column :detections, :code, :string
  end
end
