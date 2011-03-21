class SongsController < ApplicationController
  before_filter :load
  before_filter :find_song, :only => [ :show, :edit, :update, :destroy]
  
  
  def load 
    @songs = Song.all
	@tagsnum = 0
  end
  
  def index
    @title = "All songs"
    @songs = Song.paginate(:page => params[:page])
	@song = Song.new
	2.times { @song.artists.build }
	@tagsnum = 0
	
  end
  
  def show
	@title = @song.name
	@tagsnum = @song.tag_list.count 
	@tags = Song.tag_counts_on(:tags)
	@edit_tags = @song.tag_list
  end

  def new
    @title = "Add a new song"
  end
  
  def edit
    
    @title = "Edit " + @song.name
	@tagsnum = @song.tag_list.count 
	@edit_tags = @song.tag_list
	render :layout => false
  end
  
  def tag
	@songs = Song.tagged_with(params[:tag])
	@title = "Song with #{params[:tag]}"
  end 
  
  def update

	@song.tag_list = inserttags
	if @song.update_attributes(params[:song])
      
      redirect_to @song
    else
      @title = "Edit " + @song.name
      render 'edit'
    end
  end
  

  
  def create
    @song = Song.new(params[:song])
	@song.tag_list = inserttags
	@artists = createartists
	if @song.save
	  @songs = Song.all
	  @tags = @song.tag_list
	  songpara = params[:song]
	  artcount = songpara['artistcount'].to_i
	  i = 0
	  @artists.each do |artist| 
		singerre = SingerRelationship.new(:song_id => @song.id, :artist_id => artist.id )
		singerre.save
		i += 1
	  end 
	  
	  redirect_to @song
	end

  end
  
  def destroy
    @song.destroy  
    
    @songs = Song.all
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
	
	def createartists
		songpara = params[:song]
		artcount = songpara['artistcount'].to_i
		artists = Array.new

		for i in 1..artcount
			noofartist = "artist_list#{i}"
			if !params[noofartist].empty?
				artistname = params[noofartist]
				if ifartistexist(artistname)
					temp = Artist.where(:name => artistname)
					temp.each do |artist| 
						artists << artist
					end
				else
					artist = Artist.new(:name => artistname, :artist_type => "Singer")
					if artist.save
						artists << artist
					end
				end
			end
		end
		return artists
    end
	
	def ifartistexist(name)
		temp = Artist.where(:name => name)
		if temp.empty?
			return false
		end
		return true
	end
	
end
