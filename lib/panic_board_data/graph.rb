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
                     'title'         => title,
                     'color'         => color.to_s,
                     'type'          => type.to_s,
                     'total'         => total.to_s,
                     'datasequences' => [
                                         {'datapoints' => data_sequences.first.data.map do |k, v|
                                                            { 'title' => k, 'value' => v }
                                                          end}
                                        ]
                   }
      }
    end
  end

end
