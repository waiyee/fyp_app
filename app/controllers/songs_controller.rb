class SongsController < ApplicationController
  before_filter :find_song, :only => [ :show, :edit, :update, :destroy]
  
  def index
    @title = "All songs"
    @songs = Song.paginate(:page => params[:page])
  end
  
  def show
	@title = @song.name
  end

  def new
    @song = Song.new
    @title = "Add a new song"
  end
  
  def edit
    @title = "Edit " + @song.name
  end
  
  def update
    if @song.update_attributes(params[:song])
      flash[:success] = "Song updated."
      redirect_to @song
    else
      @title = "Edit " + @song.name
      render 'edit'
    end
  end
  
  def create
    @song = Song.new(params[:song])
    if @song.save
	  flash[:success] = "You add a new song"
      redirect_to @song
    else
      @title = "Add a new song"
      render 'new'
    end
  end
  
  def destroy
    @song.destroy  
    redirect_to :action => :index
  end
  
  private
    def find_song
	  @song = Song.find(params[:id])
	end  
end
