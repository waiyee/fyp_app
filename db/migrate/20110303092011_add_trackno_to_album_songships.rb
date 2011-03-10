class AddTracknoToAlbumSongships < ActiveRecord::Migration
  def self.up
    add_column :album_songships, :Trackno, :integer
	add_column :album_songships, :CDno, :integer, :default => 1
  end

  def self.down
    remove_column :album_songships, :Trackno
  end
end
