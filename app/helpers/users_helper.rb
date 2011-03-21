module UsersHelper

  def gravatar_for(user, options = { :size => 50 })
    gravatar_image_tag(user.email.downcase, :alt => user.name,
                                            :class => 'gravatar',
                                            :gravatar => options)
  end
  

  
  
  def similarsong(userlike)
	song = Array.new
	similar = Array.new
	num = userlike.size
	i = 0
	begin
		song.push(Song.find(userlike[i].song_id).find_related_tags)
		i += 1
	end while i < num && i < 5
	j = 0 
	k = 0
	
	until song[j] == nil	
		
		until song[j][k] == nil
			similar << song[j][k] 
			k += 1
		end
		j += 1
		k = 0
	end  
	similar.uniq!
	return similar
  end
end
