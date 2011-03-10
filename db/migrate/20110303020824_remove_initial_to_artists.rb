class RemoveInitialToArtists < ActiveRecord::Migration
  def self.up
    remove_column :artists, :initial
	add_column :artists, :last_name, :string
	add_column :artists, :first_name, :string
  end

  def self.down
    add_column :artists, :initial, :char
  end
end
