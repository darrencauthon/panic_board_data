require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PanicBoardData::Graph do
  it "should exist" do
    PanicBoardData::Graph.nil?.must_equal false
  end

  it "should default to an empty data_sequence array" do
    PanicBoardData::Graph.new.data_sequences.count.must_equal 0
  end

  it "should have the accepted graph types" do
    PanicBoardData::GRAPH_TYPES.must_equal [:bar, :line]
  end

  it "should have the accepted colors" do
    PanicBoardData::COLORS.must_equal [:yellow, :green, :red, :purple, :blue, :mediumGray, :pink, :aqua, :orange, :light_gray]
  end

  describe "to_hash" do

    let(:graph) { PanicBoardData::Graph.new }

    describe "first example" do
      before do
        graph.title = "Soft Drink Sales"
        graph.color = :red
        graph.total = true
        graph.type  = :bar

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
        @result['graph']['title'].must_equal 'Soft Drink Sales'
      end

      it "should set the color" do
        @result['graph']['color'].must_equal 'red'
      end

      it "should set the total" do
        @result['graph']['total'].must_equal true
      end

      it "should set the type" do
        @result['graph']['type'].must_equal 'bar'
      end

      it "should default to refreshing every 120 seconds" do
        @result['graph']['datasequences'][0]['refreshEveryNSeconds'].must_equal 120
      end

      it "should add the data sequences" do
        @result['graph']['datasequences'][0]['title'].must_equal "X-Cola"
        @result['graph']['datasequences'][0]['datapoints'][0].must_equal( { 'title' => '2008', 'value' => 22 } )
        @result['graph']['datasequences'][0]['datapoints'][1].must_equal( { 'title' => '2009', 'value' => 24 } )
        @result['graph']['datasequences'][0]['datapoints'][2].must_equal( { 'title' => '2010', 'value' => 25.5 } )
        @result['graph']['datasequences'][0]['datapoints'][3].must_equal( { 'title' => '2011', 'value' => 27.9 } )
        @result['graph']['datasequences'][0]['datapoints'][4].must_equal( { 'title' => '2012', 'value' => 31 } )
      end
    end

    describe "second example" do
      before do
        graph.title = "Another Example"
        graph.color = :blue
        graph.total = false
        graph.type  = :line

        data_sequence = PanicBoardData::DataSequence.new('Apples')
        data_sequence.refresh_every_n_seconds = 60
        data_sequence.data['1908'] = 1
        data_sequence.data['1909'] = 2
        data_sequence.data['1910'] = 3
        data_sequence.data['1911'] = 4
        data_sequence.data['1912'] = 5

        graph.data_sequences << data_sequence
        @result = graph.to_hash
      end

      it "should set the title" do
        @result['graph']['title'].must_equal 'Another Example'
      end

      it "should set the color" do
        @result['graph']['color'].must_equal 'blue'
      end

      it "should set the total" do
        @result['graph'].keys.include?('total').must_equal false
      end

      it "should set the type" do
        @result['graph']['type'].must_equal 'line'
      end

      it "should set the refreshing every n seconds value" do
        @result['graph']['datasequences'][0]['refreshEveryNSeconds'].must_equal 60
      end

      it "should add the data sequences" do
        @result['graph']['datasequences'][0]['title'].must_equal "Apples"
        @result['graph']['datasequences'][0]['datapoints'][0].must_equal( { 'title' => '1908', 'value' => 1 } )
        @result['graph']['datasequences'][0]['datapoints'][1].must_equal( { 'title' => '1909', 'value' => 2 } )
        @result['graph']['datasequences'][0]['datapoints'][2].must_equal( { 'title' => '1910', 'value' => 3 } )
        @result['graph']['datasequences'][0]['datapoints'][3].must_equal( { 'title' => '1911', 'value' => 4 } )
        @result['graph']['datasequences'][0]['datapoints'][4].must_equal( { 'title' => '1912', 'value' => 5 } )
      end
    end

    describe "third example" do
      before do
        graph.title = "Third Example"
        graph.color = :light_gray
        graph.total = true
        graph.type  = :line

        first = PanicBoardData::DataSequence.new('Apples')
        first.refresh_every_n_seconds = 5
        first.data['1908'] = 1
        first.data['1909'] = 2
        first.data['1910'] = 3
        first.data['1911'] = 4
        first.data['1912'] = 5

        second = PanicBoardData::DataSequence.new('Oranges')
        second.refresh_every_n_seconds = 10
        second.data['2008'] = 6
        second.data['2009'] = 7
        second.data['2010'] = 8
        second.data['2011'] = 9
        second.data['2012'] = 10

        graph.data_sequences << first
        graph.data_sequences << second

        @result = graph.to_hash
      end

      it "should set the title" do
        @result['graph']['title'].must_equal 'Third Example'
      end

      it "should set the color" do
        @result['graph']['color'].must_equal 'lightGray'
      end

      it "should set the total" do
        @result['graph']['total'].must_equal true
      end

      it "should set the type" do
        @result['graph']['type'].must_equal 'line'
      end

      it "should add the data sequences" do
        @result['graph']['datasequences'][0]['title'].must_equal "Apples"
        @result['graph']['datasequences'][0]['datapoints'][0].must_equal( { 'title' => '1908', 'value' => 1 } )
        @result['graph']['datasequences'][0]['datapoints'][1].must_equal( { 'title' => '1909', 'value' => 2 } )
        @result['graph']['datasequences'][0]['datapoints'][2].must_equal( { 'title' => '1910', 'value' => 3 } )
        @result['graph']['datasequences'][0]['datapoints'][3].must_equal( { 'title' => '1911', 'value' => 4 } )
        @result['graph']['datasequences'][0]['datapoints'][4].must_equal( { 'title' => '1912', 'value' => 5 } )

        @result['graph']['datasequences'][1]['title'].must_equal "Oranges"
        @result['graph']['datasequences'][1]['datapoints'][0].must_equal( { 'title' => '2008', 'value' => 6  } )
        @result['graph']['datasequences'][1]['datapoints'][1].must_equal( { 'title' => '2009', 'value' => 7  } )
        @result['graph']['datasequences'][1]['datapoints'][2].must_equal( { 'title' => '2010', 'value' => 8  } )
        @result['graph']['datasequences'][1]['datapoints'][3].must_equal( { 'title' => '2011', 'value' => 9  } )
        @result['graph']['datasequences'][1]['datapoints'][4].must_equal( { 'title' => '2012', 'value' => 10 } )
      end

      it "should set the refreshing every n seconds value" do
        @result['graph']['datasequences'][0]['refreshEveryNSeconds'].must_equal 5
        @result['graph']['datasequences'][1]['refreshEveryNSeconds'].must_equal 10
      end
    end

    describe "no color" do
      before do
        graph.title = "Soft Drink Sales"
        @result = graph.to_hash
      end

      it "should set not set a color" do
        @result['graph']['color'].nil?.must_equal true
      end
    end
  end

  describe "to_json" do
    it "should call to_json on the to_hash result" do
      graph = PanicBoardData::Graph.new

      result = Object.new

      hash = Object.new
      graph.stubs(:to_hash).returns hash

      hash.stubs(:to_json).returns result

      graph.to_json.must_be_same_as result
    end
  end
end
