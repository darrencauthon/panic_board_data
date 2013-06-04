require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PanicBoardData::Color do

  describe "all" do
    it "should return the set of accepted colors" do
      PanicBoardData::Color.all.must_equal [:yellow, :green, :red, :purple, :blue, :mediumGray, :pink, :aqua, :orange, :light_gray]
    end
  end
end

