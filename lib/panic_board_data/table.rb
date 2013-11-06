require 'csv'

module PanicBoardData
  class Table

    def self.to_csv data
      ::CSV.generate do |csv|
        data.each { |row| csv << row }
      end.strip
    end
  end
end
