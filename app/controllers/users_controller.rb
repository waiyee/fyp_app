class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update, :joining_facebook]
  before_filter :admin_user,   :only => :destroy
  before_filter :find_user, :only => [ :show,  :update, :destroy]
  

  
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end
  
  def show
    @title = @user.name
	@userlike = @user.UserLikeSong.paginate(:page => params[:page])
  end

  def facebook_create
	@user = User.new
    if current_facebook_user
	  current_facebook_user.fetch 
	  @user.email = current_facebook_user.email
	  @user.name = current_facebook_user.name
	  @user.password = "facebook"
	  @user.fb_id = current_facebook_user.id
	  if @user.save
	    sign_in @user
		redirect_to @user
	  else
		
	  end
	end
  end
  
  def joining_facebook
	if current_facebook_user
		current_facebook_user.fetch
		if @user.email == current_facebook_user.email 
			@user.fb_id = current_facebook_user.id
			redirect_to @user
		else
		end		
	else
		redirect_to root_path
	end
  end
  
  def new
    @user = User.new
	if signed_in?
		redirect_to root_path
	else     
      @title = "Sign up"
	end
  end
  
  def create
    if signed_in?
	  redirect_to root_path
	
	else
      @user = User.new(params[:user])
	  if @user.save
	    sign_in @user
	    flash[:success] = "Welcome to the Personalized Music Social Networking!"
	    redirect_to @user
	  else
  	    @title = "Sign up"
	    @user.password = ""
	    @user.password_confirmation = ""
	    render 'new'
	  end
	end
  end
  
  def edit
    @title = "Edit user"
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def destroy
	if @user.admin?
	  redirect_to root_path
	else
	  @user.destroy
      flash[:success] = "User destroyed."
      redirect_to users_path
	end
  end
  
    
  private

    

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
  
    
    
	def find_user
      @user = User.find(params[:id])
	end 

end
