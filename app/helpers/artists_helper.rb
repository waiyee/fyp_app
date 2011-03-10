module ArtistsHelper

  def findalbums(songs)
	art_albums = Array.new
	
	max = songs.size
	
	for i in 0..max-1
	  song_albums_no = songs[i].albums.size
	  
	  for j in 0..song_albums_no-1
		art_albums << songs[i].albums[j]
	  end
	  
	end  
	
	return art_albums
  end
end
