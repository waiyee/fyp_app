class PagesController < ApplicationController
  before_filter :authenticate, :only => [ :admin]
  before_filter :admin_user, :only => [ :admin]
  def home
    @title = "Home"
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end
  
  def help
    @title = "Help"
  end
  
  def admin
    @tilte = "Admin"
  end
end
