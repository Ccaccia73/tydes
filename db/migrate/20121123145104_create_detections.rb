class CreateDetections < ActiveRecord::Migration
  def change
    create_table :detections do |t|
      t.integer :user
      t.string :value

      t.timestamps
    end
  end
end
