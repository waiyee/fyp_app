# == Schema Information
# Schema version: 20110227160012
#
# Table name: album_songships
#
#  id         :integer         not null, primary key
#  album_id   :integer
#  song_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class AlbumSongship < ActiveRecord::Base
  belongs_to :song
  belongs_to :album
end
