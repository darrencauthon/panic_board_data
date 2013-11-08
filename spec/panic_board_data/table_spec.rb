require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PanicBoardData::Table do

  let(:table) do
    PanicBoardData::Table.new
  end

  describe "initialize" do

    it "should default data to an empty array" do
      PanicBoardData::Table.new.data.count.must_equal 0
    end

    it "should allow a new table to be built with data" do
      data = Object.new
      table = PanicBoardData::Table.new data
      table.data.must_be_same_as data
    end

  end

  describe "to_html" do

    describe "empty table" do

      before do
        @result = table.to_html
      end

      it "should return a result" do
        @result.must_equal "<table></table>"
      end

    end

    [:array, :result].to_objects { [
      [ [0],    "<td>0</td>"],
      [ [1],    "<td>1</td>"],
      [ [1, 2], "<td>1</td><td>2</td>"],
    ] }.each do |test|

      describe "one row" do

        before do
          table.data = [test.array]
          @result = table.to_html
        end

        it "should return a result" do
          @result.must_equal "<table><tr>#{test.result}</tr></table>"
        end

      end

    end

    [:array, :first_width, :second_width, :result].to_objects { [
      [ [0],    125, nil, "<td style=\"width: 125px\">0</td>"],
      [ [1],    200, nil, "<td style=\"width: 200px\">1</td>"],
      [ [1, 2], 102, nil, "<td style=\"width: 102px\">1</td><td>2</td>"],
      [ [1, 2], 401, 500, "<td style=\"width: 401px\">1</td><td style=\"width: 500px\">2</td>"],
    ] }.each do |test|

      describe "one row, adjusted width" do

        before do
          table.data   = [test.array]
          table.widths = [test.first_width, test.second_width]
          @result = table.to_html
        end

        it "should return a result" do
          @result.must_equal "<table><tr>#{test.result}</tr></table>"
        end

      end

    end

    [:array, :result].to_objects { [
      [ [0],           "<td><img src=\"0\" /></td>"],
      [ [1],           "<td><img src=\"1\" /></td>"],
      [ ['apple.jpg'], "<td><img src=\"apple.jpg\" /></td>"],
    ] }.each do |test|

      describe "basic image use" do

        before do
          table.data = [test.array.map { |x| table.build_image x }]
          @result = table.to_html
        end

        it "should return a result" do
          @result.must_equal "<table><tr>#{test.result}</tr></table>"
        end

      end

    end

    [:first_image, :second_image, :result].to_objects { [
      [ 0, 1, "<td><img src=\"0\" /><img src=\"1\" /></td>"],
      [ 1, 2, "<td><img src=\"1\" /><img src=\"2\" /></td>"],
    ] }.each do |test|

      describe "stacking multiple images into a single cell" do

        before do
          table.data = [[[table.build_image(test.first_image), table.build_image(test.second_image)]]]
          @result = table.to_html
        end

        it "should return a result" do
          @result.must_equal "<table><tr>#{test.result}</tr></table>"
        end

      end

    end

    [:array, :base_image_url, :result].to_objects { [
      [ [0],            "http://www.google.com",  "<td><img src=\"http://www.google.com/0\" /></td>"],
      [ [1],            "http://www.bing.com/",   "<td><img src=\"http://www.bing.com/1\" /></td>"],
      [ ['apple.jpg'],  nil,                      "<td><img src=\"apple.jpg\" /></td>"],
      [ ['apple.jpg'],  '',                       "<td><img src=\"apple.jpg\" /></td>"],
      [ ['/apple.jpg'], 'http://www.bing.com/',   "<td><img src=\"http://www.bing.com/apple.jpg\" /></td>"],
      [ ['/apple.jpg'], 'https://www.bing.com/',  "<td><img src=\"https://www.bing.com/apple.jpg\" /></td>"],
    ] }.each do |test|

      describe "basic image use" do

        before do
          table.base_image_url = test.base_image_url
          table.data           = [test.array.map { |x| table.build_image x }]

          @result = table.to_html
        end

        it "should return a result" do
          @result.must_equal "<table><tr>#{test.result}</tr></table>"
        end

      end

    end

    [:value, :result].to_objects {[
      [1, '<td class="projectsBars"><div class="barSegment value1"></div></td>'],
      [2, '<td class="projectsBars"><div class="barSegment value1"></div><div class="barSegment value2"></div></td>'],
      [8, '<td class="projectsBars"><div class="barSegment value1"></div><div class="barSegment value2"></div><div class="barSegment value3"></div><div class="barSegment value4"></div><div class="barSegment value5"></div><div class="barSegment value6"></div><div class="barSegment value7"></div><div class="barSegment value8"></div></td>']
    ]}.each do |test|

      describe "progress bars" do

        before do
          table.data = [['a', table.progress_bar_to(test.value)]]

          @result = table.to_html
        end

        it "should create a cell with the proper progress bar" do
          @result.must_equal "<table><tr><td>a</td>#{test.result}</tr></table>"
        end

      end

    end

  end

  [->(d) { PanicBoardData::Table.to_csv(d) },
   ->(d) do 
           t = PanicBoardData::Table.new
           t.data = d
           t.to_csv
         end
  ].each do |method|

    describe "to_csv" do

      before do
        @result = method.call(data)
      end

      describe "an empty set" do

        let(:data) { [] }

        it "should return an empty string" do
          @result.must_equal ''
        end

      end

      [:array, :result].to_objects { [
        [ [0],        "0"            ],
        [ [1],        "1"            ],
        [ [1,2],      "1,2"          ],
        [ [3,4, '"'], "3,4,\"\"\"\"" ]
      ] }.each do |test|

        describe "one row" do

          let(:data) { [ test.array ] }

          it "should return the single value" do
            @result.must_equal test.result
          end

        end

      end

      [:first_row, :second_row, :result].to_objects { [
        [ [0], [1], "0\n1" ],
      ] }.each do |test|

        describe "two rows" do

          let(:data) { [ test.first_row, test.second_row ] }

          it "should return the single value" do
            @result.must_equal test.result
          end

        end

      end

    end

  end

end
