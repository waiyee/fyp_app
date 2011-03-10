require 'nokogiri' 
require 'open-uri'
require 'rexml/document'
include REXML

class ArtistsController < ApplicationController
  before_filter :find_artist, :only => [ :show, :edit, :update]
  before_filter :authenticate, :only => [ :addallsingersfrommj, :addfromcm]
  before_filter :admin_user, :only => [ :addallsingersfrommj, :addfromcm]
  
  def index
    @title = "All Artists"
    @artists = Artist.paginate(:page => params[:page])
		
  end
  
  def female
    @tilte = "Female Artist"
	@artists = Artist.paginate_by_sql ['select * from artists where male_female_group = 2'], :page => params[:page]
  end
  
  def male
    @tilte = "Male Artist"
	@artists = Artist.paginate_by_sql ['select * from artists where male_female_group = 1'], :page => params[:page]
  end
  
  def group
    @tilte = "Group Artist"
	@artists = Artist.paginate_by_sql ['select * from artists where male_female_group = 3'], :page => params[:page]
  end
  
  def show
	@title = @artist.name
  end

  def new
    @artist = Artist.new
    @title = "Add a new artist"
  end
  
  def edit
    @title = "Edit " + @artist.name
  end
  
  def update
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
  
  def addallsingersfrommj
    @no_of_artists = 0
	@no_of_artists += admincreate("http://tw.mojim.com/twza2.htm", 1, "A-BEN", "鍾立風", 1)
	@no_of_artists += admincreate("http://tw.mojim.com/twzb2.htm", 2, "A-Lin", "﻿於智佳", 2)	
	@no_of_artists += admincreate("http://tw.mojim.com/twzc2.htm", 1, "1306天王組合", "Fun4", 3)
  end  
  
  def addfromcm
  
	stype = Array["m","f","t"]
	mfg = Array[1,2,3]
	@no_of_artists = 0
	for i in 0..2
		
		for j in 1..7
			artistnames = Array.new
			artisturl = Array.new
			artistfull = Array.new
			tempnum = 0
			url = "http://www.coolmanmusic.com/cmwww/singers.php?stype=" + stype[i] + "&char=&page=#{j}" 
			doc = Nokogiri::HTML(open(url))
			# For Artist name
			doc.xpath('//td[@width="20%"]').each do | method_span |
				artistnames << method_span.content
			end
			
			doc.xpath('//td[@width="40%"]//a').each do | method_span |
				artisturl << method_span.values
				artistfull << method_span.content
			end
			tempnum = artistfull.size
			if tempnum == 0
				break
			end
			for k in 0..tempnum-1
				temparray= artistfull[k].split(",")
				singer_last = temparray[0]
				singer_first = temparray[1]
				artist = Artist.new(:name =>artistnames[k], :artist_type => "Signer", :male_female_group => mfg[i], :last_name => singer_last, :first_name => singer_first)
				artist.save
				@no_of_artists +=1
				addalbumsfmcm(artisturl[k],artist.id)
			end
		end
	end
  end
  
  private
    def find_artist
      @artist = Artist.find(params[:id])
	end  
	
	def songlyricfmcm(inurl)
		url = "http://www.coolmanmusic.com/cmwww/#{inurl[0]}" 
		doc = Nokogiri::HTML(open(url))
		return doc.xpath('//table[@width="100%"]//tr//td//td//td')[6].to_s
	end
  
    def addalbumsfmcm(inurl, artistid)
	
		for i in 1..25
			albumsnames = Array.new
			albumsdate = Array.new
			@albums = Array.new
			
			url = "http://www.coolmanmusic.com/cmwww/#{inurl[0]}&page=#{i}" 

			doc = Nokogiri::HTML(open(url))
			
			doc.xpath('//td[@width="75%"]//b').each do | method_span |
				temp = method_span.content
				if temp.length >0
					albumsnames << temp
				end
			end
			doc.xpath('//td[@width="25%"]').each do | method_span |
				albumsdate << method_span.content[6..15]
			end
			albumno = albumsnames.size
			if albumno == 0
				break;
			end
	
			j = 0
			begin 
				@albums[j] = Album.new(:name => albumsnames[j], :release_date => albumsdate[j])
				@albums[j].save
				aaship = AlbumArtistship.new(:album_id => @albums[j].id, :artist_id => artistid)
				aaship.save
				j += 1
			end until j >= albumno
			
			count = -1
			doc.xpath('//td[@width="75%"]//td//a').each do | method_span |
				temp = method_span.content
				size = temp.length
				if size >0
					case temp[0]
					when "A"
						disc = 1
						track = temp[1..2].to_i
						songname = temp[5..size-1]
					when "B"
						disc = 2
						track = temp[1..2].to_i
						songname = temp[5..size-1]
					when "V"
						break
					when "D"
						disc = temp[5]
						track = temp[9..10].to_i
						songname = temp[13..size-1]
					else
						disc = 1
						track = temp[0..1].to_i
						songname = temp[4..size-1]
					end
					
					if track == 1 && temp[0] != "B" && temp[0] != "D"
						count += 1
					end
					tempurl = method_span.values
					
					songlyric = songlyricfmcm(tempurl).encode("UTF-8")
					song = Song.new(:name => songname, :lyric => songlyric )
					song.save
					
					asship = AlbumSongship.new(:album_id => @albums[count].id, :song_id => song.id, :Trackno => track, :CDno => disc)
					asship.save
					sship = SingerRelationship.new(:song_id => song.id, :artist_id => artistid )
					sship.save
				end
				
			end
			
		end
	end 
	
    def admincreate(url, wherestart, startname, endname, mfg)
    
		hvtostart = 0
		hvtoend = 0
		@names = Array.new
		doc = Nokogiri::HTML(open(url))

			doc.xpath('//td').each do | method_span |
				if (method_span.content== startname)
					hvtostart += 1
				end 
				hvdoc = method_span.content.include? "document"
				if (method_span.content != "" && !hvdoc && hvtostart >= wherestart && hvtoend == 0 )
				  @names << method_span.content 
				end 
				if (method_span.content  == endname)
				  hvtoend += 1
				end
			end	

		size = @names.size
		
		for i in 0..size-1
			@artist = Artist.new(:name =>@names[i], :artist_type => "Singer", :male_female_group => mfg )
			@artist.save 		
		end
		
		return size
    end
  
end

