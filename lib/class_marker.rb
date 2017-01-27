require 'csv'

class ClassMarker
  attr_accessor :rows_with_class

  def initialize
    keywords = ['String', 'System', 'Exception', 'ArrayList', 'HashMap', 'Object',
      'Thread', 'Class', 'Date', 'Iterator']
    @rows_with_class = FileReader.new.rows.map { |line| FileRow.new(line, keywords) }
  end

  def export
    CSV.open("results/result.csv", "wb") do |csv|
      csv << FileRow.stats_header
      @rows_with_class.each do |row|
        csv << row.stats
      end
    end

    CSV.open("results/entries.csv", "wb") do |csv|
      csv << ['index_number', 'line_of_code']
      @rows_with_class.each_with_index do |row, index|
        csv << [index, row.text]
      end
    end
  end
end
