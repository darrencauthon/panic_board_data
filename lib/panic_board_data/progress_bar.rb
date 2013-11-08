module PanicBoardData

  class ProgressBar

    attr_accessor :value

    def to_s
      "<td class=\"projectsBars\">#{bars}</td>"
    end

    private

    def bars
      (1..self.value).to_a
        .map { |x| "<div class=\"barSegment value#{x}\"></div>" }
        .join
    end

  end

end
