class AddIndexToNegativesCode < ActiveRecord::Migration
  def change
  	add_index :negatives, :code, unique: true
  end
end
