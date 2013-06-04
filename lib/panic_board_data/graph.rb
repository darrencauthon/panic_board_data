module PanicBoardData

  GRAPH_TYPES = [:bar, :line]
  COLORS = [:yellow, :green, :red, :purple, :blue, :mediumGray, :pink, :aqua, :orange, :light_gray]

  class Graph

    attr_accessor :title, :color, :total, :type
    attr_accessor :data_sequences

    def initialize
      @data_sequences = []
    end

    def to_hash
      { 
        'graph' => { 
                     'title' => 'Soft Drink Sales',
                     'color' => 'red',
                     'type'  => 'bar',
                     'total' => 'true',
                     'datapoints' => [ 
                                       { 'title' => '2008', 'value' => 22 },
                                       { 'title' => '2009', 'value' => 24 },
                                       { 'title' => '2010', 'value' => 25.5 },
                                       { 'title' => '2011', 'value' => 27.9 },
                                       { 'title' => '2012', 'value' => 31 }
                                     ]
                   }
      }
    end
  end

end
