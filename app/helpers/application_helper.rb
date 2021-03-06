module ApplicationHelper

  # Return a title on a per-page basis.
  def title
    base_title = "Personalized Music Social Networking"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  # Return logo
  def logo
    image_tag("fyplogo.png", :alt => "FYP App", :class => "round")
  end

end
