# frozen_string_literal: true

require_relative './information'

class Show
  ITEMS_ON_THE_LINE = 3

  def initialize(objects)
    @objects = objects
  end

  def show_object_list
    output_rows = (@objects.size / ITEMS_ON_THE_LINE.to_f).ceil
    array_by_row = Array.new(output_rows) { [] }
    index = 0

    @objects.each do |object|
      array_by_row[index] << object
      index += 1
      index = 0 if index == output_rows
    end

    output_string = ''
    longest_word_length = @objects.max_by(&:length).length
    array_by_row.each do |row|
      output_string += row.map { |item| item.ljust(longest_word_length) }.join("\t\t")
      output_string += "\n"
    end
    output_string.strip
  end

  def show_object_detail
    total_block_size, object_list = @objects
    output_string = "total #{total_block_size}\n"
    object_list.each do |object|
      output_string += "#{object}\n"
    end
    output_string.strip
  end
end
