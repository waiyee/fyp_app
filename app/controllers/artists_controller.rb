class ArtistsController < ApplicationController
  
  def index
    @title = "All Artists"
    @artists = Artist.paginate(:page => params[:page])
  end
  
  def female
    @tilte = "Female Artist"
	@artists = Artist.paginate_by_sql ['select * from artists where sex = 2'], :page => params[:page]
  end
  
  def male
    @tilte = "Male Artist"
	@artists = Artist.paginate_by_sql ['select * from artists where sex = 1'], :page => params[:page]
  end
  
  def group
    @tilte = "Group Artist"
	@artists = Artist.paginate_by_sql ['select * from artists where sex = 3'], :page => params[:page]
  end
  
  def show
    @artist = Artist.find(params[:id])
	@title = @artist.name
  end

  def new
    @artist = Artist.new
    @title = "Add a new artist"
  end
  
  def edit
    @artist = Artist.find(params[:id])
    @title = "Edit " + @artist.name
  end
  
  def update
    @artist = Artist.find(params[:id])
    if @artist.update_attributes(params[:artist])
      flash[:success] = "Artist updated."
      redirect_to @artist
    else
      @title = "Edit " + @artist.name
      render 'edit'
    end
  end
  
  def create
    @artist = Artist.new(params[:artist])
    if @artist.save
	  flash[:success] = "You add a new artist"
      redirect_to @artist
    else
      @title = "Add a new artist"
      render 'new'
    end
  end
end

