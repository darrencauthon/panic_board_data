module PanicBoardData

  class DataSequence
    attr_accessor :data
    def initialize(name)
      @data = {}
    end
  end

  class Graph
    attr_accessor :title
    attr_accessor :data_sequences

    def initialize
      @data_sequences = []
    end

    def to_hash
      { 
        'graph' => { 
                     'title' => 'Soft Drink Sales',
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
