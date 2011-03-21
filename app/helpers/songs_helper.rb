module SongsHelper
	include ActsAsTaggableOn::TagsHelper
	def isuserliked
		@user = current_user
		if (UserLikeSong.where(:user_id=>@user.id, :song_id=>@song.id).empty?)
			return false
		end
		return true
	
	end

end
