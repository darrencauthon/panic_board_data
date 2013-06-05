module PanicBoardData

  class DataSequence
    attr_accessor :data, :title, :refresh_every_n_seconds

    def initialize(title)
      @title = title
      @data = {}
      @refresh_every_n_seconds = 120
    end
  end

end
