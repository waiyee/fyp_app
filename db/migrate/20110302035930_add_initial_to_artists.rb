class AddInitialToArtists < ActiveRecord::Migration
  def self.up
    add_column :artists, :Initial, :char
  end

  def self.down
    remove_column :artists, :Initial
  end
end
