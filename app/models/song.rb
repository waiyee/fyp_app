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
  
  attr_accessible :name, :lyric
  
  validates :name,  :presence => true,
                    :length   => { :maximum => 200 }
  validates :lyric, :presence => true
    
  has_many :singer_relationships	
  has_many :artists, :through => :singer_relationships
  
  has_many :album_songships	
  has_many :album, :through => :album_songships
  
end
