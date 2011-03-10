# == Schema Information
# Schema version: 20110304140406
#
# Table name: album_artistships
#
#  id         :integer         not null, primary key
#  album_id   :integer
#  artist_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class AlbumArtistship < ActiveRecord::Base
  validates :album_id,  :presence => true
  validates :artist_id,  :presence => true
  belongs_to :artist
  belongs_to :album
end
