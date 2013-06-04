require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PanicBoardData::Graph do
  it "should exist" do
    PanicBoardData::Graph.nil?.must_equal false
  end

  it "should default to an empty data_sequence array" do
    PanicBoardData::Graph.new.data_sequences.count.must_equal 0
  end

  describe "to_hash" do

    let(:graph) { PanicBoardData::Graph.new }

    before do
      graph.title = "Soft Drink Sales"
      graph.color = :red

      data_sequence = PanicBoardData::DataSequence.new('X-Cola')
      data_sequence.data['2008'] = 22
      data_sequence.data['2009'] = 24
      data_sequence.data['2010'] = 25.5
      data_sequence.data['2011'] = 27.9
      data_sequence.data['2012'] = 31

      graph.data_sequences << data_sequence
      @result = graph.to_hash
    end

    it "should set the title" do
      @result['graph']['title'] = 'Soft Drink Sales'
    end

    it "should set the color" do
      @result['graph']['color'] = 'red'
    end

    it "should add the data sequences" do
      @result['graph']['datapoints'][0].must_equal( { 'title' => '2008', 'value' => 22 } )
      @result['graph']['datapoints'][1].must_equal( { 'title' => '2009', 'value' => 24 } )
      @result['graph']['datapoints'][2].must_equal( { 'title' => '2010', 'value' => 25.5 } )
      @result['graph']['datapoints'][3].must_equal( { 'title' => '2011', 'value' => 27.9 } )
      @result['graph']['datapoints'][4].must_equal( { 'title' => '2012', 'value' => 31 } )
    end

let(:expected_result) do 
<<EOF
  {
  "graph" : {
  "title" : "Soft Drink Sales",
  "datasequences" : [
  {
  "title" : "X-Cola",
  "datapoints" : [
  { "title" : "2008", "value" : 22 },
  { "title" : "2009", "value" : 24 },
  { "title" : "2010", "value" : 25.5 },
  { "title" : "2011", "value" : 27.9 },
  { "title" : "2012", "value" : 31 },
  ]
  },
  {
  "title" : "Y-Cola",
  "datapoints" : [
  { "title" : "2008", "value" : 18.4 },
  { "title" : "2009", "value" : 20.1 },
  { "title" : "2010", "value" : 24.8 },
  { "title" : "2011", "value" : 26.1 },
  { "title" : "2012", "value" : 29 },
  ]
  }
  ]
  }
  }
EOF
end
  end
end
