require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "progress_bar_to" do
  [:value, :result].to_objects {[
    [1],
    [2],
    [8]
  ]}.each do |test|

    describe "progress bars" do

      before do
        @result = progress_bar_to(test.value)
      end

      it "should create a progress bar with the right value" do
        @result.is_a?(PanicBoardData::ProgressBar).must_equal true
        @result.value.must_equal test.value
      end

    end

  end

end
