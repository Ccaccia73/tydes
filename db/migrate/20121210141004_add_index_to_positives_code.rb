class AddIndexToPositivesCode < ActiveRecord::Migration
  def change
  	add_index :positives, :code, unique: true
  end
end
