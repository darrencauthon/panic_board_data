require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "progress_bar_to" do

  [1, 2, 3, 4, 5, 6, 7, 8].each do |value|

    describe "progress bars" do

      before do
        @result = progress_bar_to(value)
      end

      it "should create a progress bar with the right value" do
        @result.is_a?(PanicBoardData::ProgressBar).must_equal true
        @result.value.must_equal value
      end

    end

  end

end
