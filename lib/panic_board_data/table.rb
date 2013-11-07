require 'csv'

module PanicBoardData
  class Table

    def to_html
      "<table></table>"
    end

    def self.to_csv data
      ::CSV.generate do |csv|
        data.each { |row| csv << row }
      end.strip
    end
  end
end
