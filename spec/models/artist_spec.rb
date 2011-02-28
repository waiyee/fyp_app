require 'spec_helper'

describe Artist do

  before(:each) do
    @attr = { :name => "Example Artist", 
			  :nation => "China",
			  :city => "Hong Kong", 
			  :artist_type => "Singer",
			  :bio => "Bio"}
  end

  it "should create a new instance given valid attributes" do
    Artist.create!(@attr)
  end
  
  it "should require a name" do
    no_name_artist = Artist.new(@attr.merge(:name => ""))
    no_name_artist.should_not be_valid
  end
  

  
  it "should reject names that are too long" do
    long_artist = "a" * 51
    long_name_artist = Artist.new(@attr.merge(:name => long_name))
    long_name_artist.should_not be_valid
  end
end
