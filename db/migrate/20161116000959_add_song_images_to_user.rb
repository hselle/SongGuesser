class AddSongImagesToUser < ActiveRecord::Migration
  def change
    add_column :users, :song_images, :string, array: true, default: []
  end
end
