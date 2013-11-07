require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PanicBoardData::Table do

  let(:table) do
    PanicBoardData::Table.new
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

  end

  describe "to_csv" do

    before do
      @result = PanicBoardData::Table.to_csv data
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
