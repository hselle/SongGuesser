class AddRecordsToUser < ActiveRecord::Migration
  def change
    add_column :users, :records, :text, array: true, default: []
  end
end
