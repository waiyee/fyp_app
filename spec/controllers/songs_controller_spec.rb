require 'spec_helper'

describe SongsController do
  render_views
  
  describe "GET 'show'" do

    before(:each) do
      @song = Factory(:song)
    end

    it "should be successful" do
      get :show, :id => @song
      response.should be_success
    end

    it "should find the right song" do
      get :show, :id => @song
      assigns(:song).should == @song
    end
	
	it "should have the right title" do
      get :show, :id => @song
      response.should have_selector("title", :content => @song.name)
    end

    it "should include the song's name" do
      get :show, :id => @song
      response.should have_selector("h2", :content => @song.name)
    end
	
  end

  describe "GET 'new'" do

    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Add a new song")
    end
  end
  
  describe "POST 'create'" do

    describe "failure" do

      before(:each) do
        @attr = { :name => "", :lyric => ""}
      end

      it "should not create a song" do
        lambda do
          post :create, :song => @attr
        end.should_not change(Song, :count)
      end

      it "should have the right title" do
        post :create, :song => @attr
        response.should have_selector("title", :content => "Add a new song")
      end

      it "should render the 'new' page" do
        post :create, :song => @attr
        response.should render_template('new')
      end
    end
	describe "success" do

      before(:each) do
        @attr = { :name => "New Song", :lyric => "New Lyric" }
      end

      it "should create a song" do
        lambda do
          post :create, :song => @attr
        end.should change(Song, :count).by(1)
      end

      it "should redirect to the song show page" do
        post :create, :song => @attr
        response.should redirect_to(user_path(assigns(:song)))
      end  
	  
	  it "should have a add song message" do
        post :create, :user => @attr
        flash[:success].should =~ /You add a new song/i
      end
	  
    end
	
  end

end
