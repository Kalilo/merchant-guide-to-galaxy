class ReadFile
  attr_accessor :file_name
  attr_reader :content

  def initialize(file_name)
    @file_name = file_name
  end

  def read
    open_file
    @content = []

    close_file
  end

  private

  def open_file
    @file = File.open @file_name, 'r'
  end

  def close_file
    @file.close
  end

  def eof?
    @file.eof?
  end
end