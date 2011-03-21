# == Schema Information
# Schema version: 20110227082932
#
# Table name: songs
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  lyric      :text
#  created_at :datetime
#  updated_at :datetime
#

class Song < ActiveRecord::Base
  include ActionView::Helpers  
  
  attr_accessible :name, :lyric
  
  acts_as_taggable
  #acts_as_taggable_on :name
  
  validates :name,  :presence => true,
                    :length   => { :maximum => 200 }
  validates :lyric, :presence => true
    
  before_validation :santize_msg

  has_many :singer_relationships	
  has_many :artists, :through => :singer_relationships
  
  accepts_nested_attributes_for :artists
  
  has_many :album_songships	
  has_many :albums, :through => :album_songships
  
  has_many :UserLikeSong	
  has_many :users, :through => :UserLikeSong
  
  def santize_msg
	self.name = sanitize(self.name)
	self.lyric = sanitize(self.lyric)
  end

=begin
  def artist_attributes=(attributes)
	  @artist = Artist.new
	  songpara = [params:song]
	  artistname = songpara['artists_attribute']['name']
	  @artist = Artist.where(:name =>artistname)
	  if (@artist.empty?)
		@artist.name = artistname 
		@artist.save
	  else
	  
	  end	  
  end
=end  
  
end
