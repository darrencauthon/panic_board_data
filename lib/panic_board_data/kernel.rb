module Kernel
  def progress_bar_to int
    progress_bar = PanicBoardData::ProgressBar.new
    progress_bar.value = int
    progress_bar
  end

  def build_image value
    "<img src=\"#{value}\" />"
  end
end
