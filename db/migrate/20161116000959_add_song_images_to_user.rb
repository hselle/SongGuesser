class AddSongImagesToUser < ActiveRecord::Migration
  def change
    add_column :users, :song_images, :text, array: true, default: []
  end
end
