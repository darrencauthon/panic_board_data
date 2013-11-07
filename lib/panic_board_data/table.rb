# http://www.panic.com/statusboard/docs/table_tutorial.pdf
require 'csv'

module PanicBoardData
  class Table

    attr_accessor :data, :widths, :base_image_url

    def build_image value

      url = [self.base_image_url, value]
              .select { |x| x.to_s != '' }
              .map    { |x| x.to_s.strip }
              .map    { |x| x.gsub('/', '') }
              .join('/')
              .gsub('http:', 'http://')
              .gsub('https:', 'https://')
      "<img src=\"#{url}\" />"
    end

    def to_html
      result = "<table>"

      if data
        data.each do |record|
          result << "<tr>"
          record.each_with_index do |value, index|
            value = value.join('') if value.is_a?(Array)
            if widths && widths[index]
              result << "<td style=\"width: #{widths[index]}px\">#{value}</td>"
            else
              result << "<td>#{value}</td>"
            end
          end
          result << "</tr>"
        end
      end

      result << "</table>"
    end

    def self.to_csv data
      ::CSV.generate do |csv|
        data.each { |row| csv << row }
      end.strip
    end
  end
end
