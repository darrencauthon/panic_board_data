# http://www.panic.com/statusboard/docs/table_tutorial.pdf
require 'csv'

module PanicBoardData
  class Table

    attr_accessor :data, :widths, :base_image_url

    def initialize(data = [])
      @data = data
    end

    def build_image value
      "<img src=\"#{url_for(value)}\" />"
    end

    def to_html
      "<table>#{data_to_table_rows}</table>"
    end

    def to_csv
      self.class.to_csv self.data
    end

    def self.to_csv data
      ::CSV.generate do |csv|
        data.each { |row| csv << row }
      end.strip
    end

    private

    def url_for value
      [self.base_image_url, value]
        .select { |x| x.to_s != '' }
        .map    { |x| x.to_s.strip }
        .map    { |x| x.gsub('/', '') }
        .join('/')
        .gsub('http:', 'http://')
        .gsub('https:', 'https://')
    end

    def data_to_table_rows
      return '' unless data
      data.map { |r| build_row_for r }.join
    end

    def build_row_for record
      result = record.each_with_index.map { |v, i| build_cell_for v, i }.join
      "<tr>#{result}</tr>"
    end

    def build_cell_for value, index
      value = flatten_a_value_array_to_a_single_value value
      width = get_width_for index
      render_cell value, width
    end

    def flatten_a_value_array_to_a_single_value value
      value.is_a?(Array) ? value.join('') : value
    end

    def get_width_for index
      widths ? widths[index] : nil
    end

    def render_cell value, width
      width ? "<td style=\"width: #{width}px\">#{value}</td>"
            : "<td>#{value}</td>"
    end
  end
end
