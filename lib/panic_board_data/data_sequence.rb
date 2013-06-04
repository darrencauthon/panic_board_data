module PanicBoardData

  class DataSequence
    attr_accessor :data, :title

    def initialize(title)
      @title = title
      @data = {}
    end
  end

end
