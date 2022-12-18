# frozen_string_literal: true

require_relative './information'
require_relative './content'

class Show
  ITEMS_ON_THE_LINE = 3

  def initialize(options)
    @options = options
  end

  def contents_list
    @options[:long] ? contents_name_list_in_long_format : contents_name_list
  end

  private

  def contents_name_list
    contents = Content.new(@options).find_contents
    output_rows = (contents.size / ITEMS_ON_THE_LINE.to_f).ceil
    array_by_row = Array.new(output_rows) { [] }
    index = 0

    contents.each do |content|
      array_by_row[index] << content
      index += 1
      index = 0 if index == output_rows
    end

    output_string = ''
    longest_word_length = contents.max_by(&:length).length
    array_by_row.each do |row|
      output_string += row.map { |item| item.ljust(longest_word_length) }.join("\t\t")
      output_string += "\n"
    end
    output_string.strip
  end

  def contents_name_list_in_long_format
    informations = Information.new(@options).list_contents_in_the_long_format
    total_block_size, contents_list = informations
    output_string = "total #{total_block_size}\n"
    contents_list.each do |content|
      output_string += "#{content}\n"
    end
    output_string.strip
  end
end
