class AlbumsController < ApplicationController
  before_filter :find_album, :only => [ :show, :edit, :update, :destroy]
  
  def index
    @title = "All Album"
    @albums = Album.paginate(:page => params[:page])
  end
  
  def show
	@title = @album.name
  end

  def new
    @album = Album.new
    @title = "Add a new album"
  end
  
  def edit
    @title = "Edit " + @album.name
  end
  
  def update
    if @album.update_attributes(params[:album])
      flash[:success] = "Album updated."
      redirect_to @album
    else
      @title = "Edit " + @album.name
      render 'edit'
    end
  end
  
  def create
    @album = Album.new(params[:album])
    if @album.save
	  flash[:success] = "You add a new album"
      redirect_to @album
    else
      @title = "Add a new album"
      render 'new'
    end
  end
  
  def destroy
    @album.destroy  
    redirect_to :action => :index
  end
  
  private
    def find_album
	  @album = Album.find(params[:id])
	end  

end
