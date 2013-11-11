# http://www.panic.com/statusboard/docs/graph_tutorial.pdf
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
        'graph' => graph
      }
    end

    def to_json
      to_hash.to_json
    end

    private

    def graph
      the_graph = { 
                    'title'         => title,
                    'color'         => formatted_color,
                    'type'          => type.to_s,
                    'total'         => total,
                    'datasequences' => formatted_data_sequences
                  }
      the_graph.delete('color') if the_graph['color'] == ''
      the_graph.delete('total') unless the_graph['total'] == true
      the_graph
    end

    def formatted_data_sequences
      data_sequences.map do |data_sequence|
         {
           'title'                => data_sequence.title,
           'refreshEveryNSeconds' => data_sequence.refresh_every_n_seconds,
           'datapoints'           => data_points_for(data_sequence)
         }
      end
    end

    def data_points_for data_sequence
      data_sequence.data.map { |k, v| { 'title' => k, 'value' => v } }
    end

    def formatted_color
      color == :light_gray ? 'lightGray' : color.to_s
    end
  end

end
