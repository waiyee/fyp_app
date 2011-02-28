class AddSexToArtists < ActiveRecord::Migration
  def self.up
    add_column :artists, :sex, :integer
	#1 for male, 2 for female, 3 for group
	remove_column :artists, :nation
	remove_column :artists, :city
	add_column :artists, :city_id, :integer
  end

  def self.down
    remove_column :artists, :sex
  end
end
