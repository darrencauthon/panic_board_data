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

  [:value, :result].to_objects { [
    [ 0,           "<img src=\"0\" />"],
    [ 1,           "<img src=\"1\" />"],
    [ 'apple.jpg', "<img src=\"apple.jpg\" />"],
  ] }.each do |test|

    describe "basic image use" do

      before do
        @result = build_image test.value
      end

      it "should return a result" do
        @result.must_equal test.result
      end

    end

  end
end
