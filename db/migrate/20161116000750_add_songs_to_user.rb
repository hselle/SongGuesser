class AddSongsToUser < ActiveRecord::Migration
  def change
    add_column :users, :songs, :text, array: true, default: []
  end
end
