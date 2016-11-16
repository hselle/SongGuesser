class AddSongsToUser < ActiveRecord::Migration
  def change
    add_column :users, :songs, :string, array: true, default: []
  end
end
