class CreateUserLikeSongs < ActiveRecord::Migration
  def self.up
    create_table :user_like_songs do |t|
      t.integer :user_id
      t.integer :song_id

      t.timestamps
    end
  end

  def self.down
    drop_table :user_like_songs
  end
end
