module Kernel
  def progress_bar_to int
    progress_bar = PanicBoardData::ProgressBar.new
    progress_bar.value = int
    progress_bar
  end

  def build_image value
    url_for = ->(value) do
                          [value]
                            .select { |x| x.to_s != '' }
                            .map    { |x| x.to_s.strip }
                            .map    { |x| x.gsub('/', '') }
                            .join('/')
                            .gsub('http:', 'http://')
                            .gsub('https:', 'https://')
                        end

    "<img src=\"#{url_for.call(value)}\" />"
  end
end
