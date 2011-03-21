class UserLikeSongsController < ApplicationController
  def new
	@like = UserLikeSong.new
	@like.song_id = params[:id]
	@like.user_id = current_user
	if @like.save
		redirect_to Song.find(params[:id])
	end
	
  end

   
  def destroy
    @user = current_user
	@song = Song.find(params[:id])
	@like = UserLikeSong.where(:user_id=>@user.id, :song_id=>@song.id)
	@like.first.destroy
	redirect_to @song
  end
  
  

end
