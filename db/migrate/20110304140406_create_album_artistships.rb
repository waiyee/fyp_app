class CreateAlbumArtistships < ActiveRecord::Migration
  def self.up
    create_table :album_artistships do |t|
      t.integer :album_id
      t.integer :artist_id

      t.timestamps
    end
  end

  def self.down
    drop_table :album_artistships
  end
end
