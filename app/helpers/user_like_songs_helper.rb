module UserLikeSongsHelper
  def getsong(id)
	@userlike = UserLikeSong.find(id)
	@song = Song.find(@userlike.song_id)
	return @song
  end

end
