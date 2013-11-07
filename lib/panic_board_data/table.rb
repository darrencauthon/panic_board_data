# http://www.panic.com/statusboard/docs/table_tutorial.pdf
require 'csv'

module PanicBoardData
  class Table

    attr_accessor :data, :widths, :base_image_url

    def build_image value
      "<img src=\"#{url_for(value)}\" />"
    end

    def to_html
      "<table>#{data_to_rows}</table>"
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

    def data_to_rows
      return '' unless data
      data.map { |r| build_row_for r }.join
    end

    def build_row_for record
      result = record.each_with_index.map do |value, index|
                 build_cell_for value, index
               end.join
      "<tr>#{result}</tr>"
    end

    def build_cell_for value, index
      result = ""
      value = value.join('') if value.is_a?(Array)
      if widths && widths[index]
        result << "<td style=\"width: #{widths[index]}px\">#{value}</td>"
      else
        result << "<td>#{value}</td>"
      end
      result
    end
  end
end
