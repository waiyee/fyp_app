require 'spec_helper'

describe Song do

  before(:each) do
    @attr = { :name => "Example Song", 
			  :lyric => "Example Lryic"}
  end

  it "should create a new instance given valid attributes" do
    Song.create!(@attr)
  end
  
  it "should require a name" do
    no_name_song = Song.new(@attr.merge(:name => ""))
    no_name_song.should_not be_valid
  end
  
  it "should require a lyric" do
    no_name_song = Song.new(@attr.merge(:lyric => ""))
    no_name_song.should_not be_valid
  end
  
  it "should reject names that are too long" do
    long_name = "a" * 201
    long_name_song = Song.new(@attr.merge(:name => long_name))
    long_name_song.should_not be_valid
  end
end
