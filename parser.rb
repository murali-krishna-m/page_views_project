#!/usr/bin/ruby
require 'set'
require_relative 'log_reader_service'

class Parser
  attr_accessor :read_log_file
  def initialize(filename)
    begin
      @read_log_file = LogReaderService.new(filename)
      @page_views = page_views
      @unique_page_views = unique_page_views
    rescue StandardError => e
      e.message
    end
  end

  # This function gives the views of each page
  def page_views
    lines = @read_log_file.line_by_line_info
    views = {}
    lines.each do |line|
      page_visited, = LogReaderService.split_line_with_space(line)
      # checking if the page is already present in the hash
      views[page_visited] = 0 unless views.key?(page_visited)
      views[page_visited] += 1
    end
    views
  end

  def unique_page_views
    lines = @read_log_file.line_by_line_info
    unique_views_set_info = unique_views_set(lines)
    unique_views = {}
    # Counting the ip_addresses to get the unique views
    unique_views_set_info.each do |page, ip_set|
      count = ip_set.length
      unique_views[page] = count
    end
    unique_views
  end

  def print_view_info(type, sort_order = 'DESC')
    ordered_views_info, suffix = ordered_views(type)
    # Checking the order of the information
    ordered_views_info = ordered_views_info.reverse if sort_order == 'DESC'
    # Traversing the hash and printing the output
    ordered_views_info.each do |page, view_count|
      puts "#{page} #{view_count} #{suffix}"
    end
  end

  private

  # Getting all the ip address of each page
  def unique_views_set(lines)
    unique_views_set = {}
    lines.each do |line|
      page_visited, ip_address = LogReaderService.split_line_with_space(line)
      unique_views_set[page_visited] = Set.new unless unique_views_set.key?(page_visited)
      unique_views_set[page_visited] << ip_address
    end
    unique_views_set
  end

  def ordered_views(type)
    # Based on the type, the view values and the suffixes are being sent
    case type
    when 'UNIQUE_VIEWS'
      puts 'UNIQUE VIEWS'
      [@unique_page_views.sort_by { |_, v| v }, 'unique views']
    when 'VIEWS'
      puts 'VIEWS'
      [@page_views.sort_by { |_, v| v }, 'visits']
    else
      raise StandardError, 'Please provide one of the following types only: [UNIQUE_VIEWS, VIEWS]'
    end
  end
end

if ARGV.length.zero?
  puts 'Please provide the log filename'
  return
end

parser = Parser.new(ARGV[0])
parser.print_view_info('UNIQUE_VIEWS')
parser.print_view_info('VIEWS')
