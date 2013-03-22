class AddIndexToEvalpositivesCode < ActiveRecord::Migration
  def change
  	add_index :evalpositives, :code, unique: true
  end
end
