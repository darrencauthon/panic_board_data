module PanicBoardData
  class Graph
    attr_accessor :title

    def to_hash
      { 'graph' => { 'title' => 'Soft Drink Sales' } }
    end
  end
end
