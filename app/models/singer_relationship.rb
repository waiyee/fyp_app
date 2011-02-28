# == Schema Information
# Schema version: 20110227092759
#
# Table name: singer_relationships
#
#  id         :integer         not null, primary key
#  song_id    :integer
#  artist_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class SingerRelationship < ActiveRecord::Base
  belongs_to :song
  belongs_to :artist
end
