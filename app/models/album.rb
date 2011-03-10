# == Schema Information
# Schema version: 20110227154527
#
# Table name: albums
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  release_date :date
#  album_type   :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Album < ActiveRecord::Base

  validates :name,  :presence => true,
                    :length   => { :maximum => 200 }

  #validates_date  :release_date, :before => (Time.now + 1.year) , :invalid_date_message => "needs a valid date"
					
  has_many :album_songships	
  has_many :songs, :through => :album_songships
  
  has_many :album_artistships	
  has_many :artists, :through => :album_artistships
  
  
end
