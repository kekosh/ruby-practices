# frozen_string_literal: true

require_relative './information'
require_relative './objects'

class Show
  ITEMS_ON_THE_LINE = 3

  def initialize(options)
    @options = options
  end

  def object_list
    @options[:list] ? return_object_detail_info_list : return_object_name_list
  end

  private

  def return_object_name_list
    objects = Objects.new(@options).object_list
    output_rows = (objects.size / ITEMS_ON_THE_LINE.to_f).ceil
    array_by_row = Array.new(output_rows) { [] }
    index = 0

    objects.each do |object|
      array_by_row[index] << object
      index += 1
      index = 0 if index == output_rows
    end

    output_string = ''
    longest_word_length = objects.max_by(&:length).length
    array_by_row.each do |row|
      output_string += row.map { |item| item.ljust(longest_word_length) }.join("\t\t")
      output_string += "\n"
    end
    output_string.strip
  end

  def return_object_detail_info_list
    informations = Information.new(@options).return_detail_info_and_permissions
    total_block_size, object_info_list = informations
    output_string = "total #{total_block_size}\n"
    object_info_list.each do |object_info|
      output_string += "#{object_info}\n"
    end
    output_string.strip
  end
end
