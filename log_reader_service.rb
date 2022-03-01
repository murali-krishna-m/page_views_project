#!/usr/bin/ruby
class LogReaderService
  attr_reader :line_by_line_info

  def initialize(filename)
    raise StandardError, "Filename #{filename} not found" unless check_file_exists(filename)

    log_file = File.open(filename, 'r')
    @line_by_line_info = log_file.readlines
    log_file.close
  end

  def check_file_exists(filename)
    File.exist?(filename)
  end

  def self.split_line_with_space(record)
    record.split(' ')
  end
end
