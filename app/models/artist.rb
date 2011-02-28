# == Schema Information
# Schema version: 20110228061729
#
# Table name: artists
#
#  id          :integer         primary key
#  name        :string(255)
#  artist_type :string(255)
#  bio         :text
#  created_at  :datetime
#  updated_at  :datetime
#  sex         :integer
#  city_id     :integer
#

class Artist < ActiveRecord::Base

  validates :name,  :presence => true,
                    :length   => { :maximum => 50 }
					
  has_many :singer_relationships	
  has_many :songs, :through => :singer_relationships
  
  belongs_to :city
  
end
