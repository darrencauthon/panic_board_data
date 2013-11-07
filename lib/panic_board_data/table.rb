require 'csv'

module PanicBoardData
  class Table

    attr_accessor :data

    def to_html
      result = "<table>"

      if data
        data.each do |record|
          result << "<tr>"
          record.each do |item|
            result << "<td>#{item}</td>"
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
