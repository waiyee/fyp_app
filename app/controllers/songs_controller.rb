class SongsController < ApplicationController
  before_filter :find_song, :only => [ :show, :edit, :update, :destroy]
  
  def index
    @title = "All songs"
    @songs = Song.paginate(:page => params[:page])
  end
  
  def show
	@title = @song.name
	@tags = Song.tag_counts_on(:tags)
  end

  def new
    @song = Song.new
    @title = "Add a new song"
	@tagsnum = 0
  end
  
  def edit
    @title = "Edit " + @song.name
	@tagsnum = @song.tag_list.count 
	@tags = @song.tag_list
  end
  
  def tag
	
	@songs = Song.tagged_with(params[:tag])
	@title = "Song with #{params[:tag]}"
	
  end 
  
  def update

	@song.tag_list = inserttags
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
	@song.tag_list = inserttags
    if @song.save
	  flash[:success] = "You add a new song #{params[:song]}"
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
  
  def tag_cloud
      @tags = Song.tag_counts_on(:tags)
  end
  
  private
    def find_song
	  @song = Song.find(params[:id])
	end  
	
	def inserttags
		songpara = params[:song]
		count = songpara['count'].to_i
		tag_list = Array.new

		for i in 1..count
			nooftag = "tag_list#{i}"
			if !params[nooftag].empty?
				tag_list << params[nooftag]
			end
		end
		return tag_list
    end
end
