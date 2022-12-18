# frozen_string_literal: true

require 'etc'
require_relative './content'

class Information
  FILE_TYPE = {
    'file' => '-',
    'directory' => 'd',
    'characterSpecial' => 'c',
    'blockSpecial' => 'b',
    'fifo' => 'p',
    'link' => 'l',
    'socket' => 's'
  }.freeze

  PERMISSION_PATTERN = {
    '0' => '---',
    '1' => '--x',
    '2' => '-w-',
    '3' => '-wx',
    '4' => 'r--',
    '5' => 'r-x',
    '6' => 'rw-',
    '7' => 'rwx'
  }.freeze

  def initialize(options)
    @options = options
  end

  def list_contents_in_the_long_format
    total_block_size = 0
    contents = Content.new(@options).find_contents
    file_size_digit = take_file_size_max_digit(contents)
    long_format = contents.map do |content|
      total_block_size += File.stat(content).blocks
      filetype = FILE_TYPE[File.ftype(content)]
      stat = File::Stat.new(content)
      permissions = format_permissions(stat)
      hard_links = stat.nlink.to_s.rjust(2)
      owner_name = Etc.getpwuid(stat.uid).name
      group_name = Etc.getgrgid(stat.gid).name
      file_size = stat.size.to_s.rjust(file_size_digit)
      last_modified = stat.mtime.strftime('%_m %_d %_R')
      "#{filetype}#{permissions} #{hard_links} #{owner_name}  #{group_name}  #{file_size} #{last_modified} #{content}"
    end
    [total_block_size, long_format]
  end

  private

  def take_file_size_max_digit(contents)
    length_list = []
    contents.each do |object|
      length_list.push File::Stat.new(object).size.to_s.length
    end
    length_list.max
  end

  def format_permissions(stat)
    permission_label = ''
    octal_mode = stat.mode.to_s(8)

    octal_mode.slice(-3, 3).each_char do |number|
      permission_label += PERMISSION_PATTERN[number]
    end
    permission_label
  end
end
