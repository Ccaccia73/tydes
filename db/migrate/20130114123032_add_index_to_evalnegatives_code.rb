class AddIndexToEvalnegativesCode < ActiveRecord::Migration
  def change
  	add_index :evalnegatives, :code, unique: true
  end
end
