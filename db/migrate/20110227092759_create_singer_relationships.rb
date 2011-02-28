class CreateSingerRelationships < ActiveRecord::Migration
  def self.up
    create_table :singer_relationships do |t|
      t.integer :song_id
      t.integer :artist_id

      t.timestamps
    end
	add_index :singer_relationships, :song_id
    add_index :singer_relationships, :artist_id
    add_index :singer_relationships, [:song_id, :artist_id], :unique => true
	
  end

  def self.down
    drop_table :singer_relationships
  end
end
