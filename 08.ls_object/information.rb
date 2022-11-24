# frozen_string_literal: true

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

  def initialize(objects)
    @objects = objects
  end

  def return_detail_info_and_permissions
    total_block_size = 0
    file_size_digit = take_file_size_max_digit(@objects)
    detailed = @objects.map do |object_name|
      total_block_size += File.stat(object_name).blocks
      filetype = FILE_TYPE[File.ftype(object_name)]
      stat = File::Stat.new(object_name)
      permissions = format_permissions(stat)
      hardlinks = stat.nlink.to_s.rjust(2)
      owner_name = Etc.getpwuid(stat.uid).name
      group_name = Etc.getgrgid(stat.gid).name
      file_size = stat.size.to_s.rjust(file_size_digit)
      last_modified = stat.mtime.strftime('%_m %_d %_R')
      "#{filetype}#{permissions} #{hardlinks} #{owner_name}  #{group_name}  #{file_size} #{last_modified} #{object_name}"
    end
    [total_block_size, detailed]
  end

  private

  def take_file_size_max_digit(objects)
    length_list = []
    objects.each do|object|
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
