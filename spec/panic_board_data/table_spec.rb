require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PanicBoardData::Table do
  it "should exist" do
    PanicBoardData::Table.nil?.must_equal false
  end

  describe "to_html" do

    let(:table) { PanicBoardData::Table.new }

    before do
      @result = table.to_html
    end

    it "should return a result" do
      @result.nil?.must_equal false
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
