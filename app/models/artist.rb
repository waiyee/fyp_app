# == Schema Information
# Schema version: 20110304140406
#
# Table name: artists
#
#  id                :integer         not null, primary key
#  name              :string(255)
#  artist_type       :string(255)
#  bio               :text
#  created_at        :datetime
#  updated_at        :datetime
#  male_female_group :integer
#  city_id           :integer
#  MBID              :integer
#  last_name         :string(255)
#  first_name        :string(255)
#

class Artist < ActiveRecord::Base
  include ActionView::Helpers  

  validates :name,  :presence => true,
                    :length   => { :maximum => 50 }
  before_validation :santize_msg
  
  has_many :singer_relationships	
  has_many :songs, :through => :singer_relationships
  
  has_many :album_artistships	
  has_many :albums, :through => :album_artistships
 

  
  belongs_to :city
  private
	  def santize_msg
		self.name = sanitize(self.name)
		self.bio = sanitize(self.bio)
		self.artist_type = sanitize(self.artist_type)
		
	  end
  
  
 
end



