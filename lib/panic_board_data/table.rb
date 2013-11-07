require 'csv'

module PanicBoardData
  class Table

    attr_accessor :data, :widths

    def to_html
      result = "<table>"

      if data
        data.each do |record|
          result << "<tr>"
          record.each_with_index do |item, index|
            if widths && widths[index]
              result << "<td style=\"width: #{widths[index]}px\">#{item}</td>"
            else
              result << "<td>#{item}</td>"
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
