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
  
  acts_as_taggable
  #acts_as_taggable_on :name
  
  validates :name,  :presence => true,
                    :length   => { :maximum => 200 }
  validates :lyric, :presence => true
    
  has_many :singer_relationships	
  has_many :artists, :through => :singer_relationships
  
  has_many :album_songships	
  has_many :albums, :through => :album_songships
  
  has_many :UserLikeSong	
  has_many :users, :through => :UserLikeSong
  
end
