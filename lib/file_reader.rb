class FileReader
  attr_accessor :files, :rows

  def initialize(directory = 'data')
    @rows = []
    read_rows
  end

  def read_rows
    list_of_file_paths.each do |file_path|
      @rows.push(*IO.readlines(file_path))
    end
  end

  private

  def list_of_file_paths
    Dir['data/**/*'].reject {|fn| File.directory?(fn) }
  end
end
