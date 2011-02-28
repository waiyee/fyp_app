class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
      t.string :name
      t.date :release_date
      t.string :album_type

      t.timestamps
    end
  end

  def self.down
    drop_table :albums
  end
end
