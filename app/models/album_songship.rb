# == Schema Information
# Schema version: 20110304140406
#
# Table name: album_songships
#
#  id         :integer         not null, primary key
#  album_id   :integer
#  song_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  Trackno    :integer
#  CDno       :integer         default(1)
#

class AlbumSongship < ActiveRecord::Base
  validates :album_id,  :presence => true
  validates :song_id,  :presence => true
  belongs_to :song
  belongs_to :album
end
