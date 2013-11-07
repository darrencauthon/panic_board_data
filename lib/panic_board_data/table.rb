require 'csv'

module PanicBoardData
  class Table

    attr_accessor :data, :widths

    def build_image value
      "<img src=\"#{value}\" />"
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
