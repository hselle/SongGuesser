class AddRecordsToUser < ActiveRecord::Migration
  def change
    add_column :users, :records, :string, array: true, default: []
  end
end
