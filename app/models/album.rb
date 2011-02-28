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

  has_many :album_songship	
  has_many :songs, :through => :album_songship
end
