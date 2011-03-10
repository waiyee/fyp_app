# == Schema Information
# Schema version: 20110310041259
#
# Table name: user_like_songs
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  song_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class UserLikeSong < ActiveRecord::Base

  validates :user_id,  :presence => true
  validates :song_id,  :presence => true
  
  belongs_to :song
  belongs_to :user
end
