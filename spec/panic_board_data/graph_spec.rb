require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PanicBoardData::Graph do
  it "should exist" do
    PanicBoardData::Graph.nil?.must_equal false
  end

  describe "to_hash" do

    let(:graph) { PanicBoardData::Graph.new }

    before do
      graph.title = "Soft Drink Sales"
      @result = graph.to_hash
    end

    it "should set the title" do
      @result['graph']['title'] = 'Soft Drink Sales'
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
