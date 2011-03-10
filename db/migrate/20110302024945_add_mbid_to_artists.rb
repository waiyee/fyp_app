class AddMbidToArtists < ActiveRecord::Migration
  def self.up
    add_column :artists, :MBID, :integer
	rename_column :artists, :sex, :male_female_group
  end

  def self.down
    remove_column :artists, :MBID
  end
end
