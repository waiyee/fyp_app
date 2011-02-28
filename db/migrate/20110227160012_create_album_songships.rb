class CreateAlbumSongships < ActiveRecord::Migration
  def self.up
    create_table :album_songships do |t|
      t.integer :album_id
      t.integer :song_id

      t.timestamps
    end
  end

  def self.down
    drop_table :album_songships
  end
end
