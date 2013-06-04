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
                     'color'         => formatted_color,
                     'type'          => type.to_s,
                     'total'         => total.to_s,
                     'datasequences' => formatted_data_sequences
                   }
      }
    end

    private

    def formatted_data_sequences
      data_sequences.map do |data_sequence|
         {
           'title'                => data_sequence.title,
           'refreshEveryNSeconds' => 120,
           'datapoints'           => data_points_for(data_sequence)
         }
      end
    end

    def data_points_for data_sequence
      data_sequence.data.map do |k, v|
        { 'title' => k, 'value' => v }
      end
    end

    def formatted_color
      color == :light_gray ? 'lightGray' : color.to_s
    end
  end

end
