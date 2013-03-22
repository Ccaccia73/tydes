class CreateEvalnegatives < ActiveRecord::Migration
  def change
    create_table :evalnegatives do |t|
      t.string :name
      t.string :code
      t.string :dir
      t.string :image
      t.integer :x
      t.integer :y
      t.integer :detections
      t.integer :positives

      t.timestamps
    end
  end
end
