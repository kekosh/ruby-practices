# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../show'

class ShowTest < Minitest::Test
  def setup
    @data_in_a_row = ['.', 'for_test', 'test1.rb', 'test2.rb', 'test3.txt']
    @data_list_option = [24, [
      'drwxr-xr-x  6 kekosh  staff  192 11 27 16:57 .',
      'drwxr-xr-x  3 kekosh  staff   96 11 23 20:38 for_test',
      '-rw-r--r--  1 kekosh  staff   58 11 24 19:11 test1.rb',
      '-rw-r--r--  1 kekosh  staff   73 11 24 19:13 test2.rb',
      '-rw-r--r--  1 kekosh  staff  211 11 27 16:57 test3.txt'
    ]]

    @data_in_a_row_result = ".        \t\ttest1.rb \t\ttest3.txt\nfor_test \t\ttest2.rb"
    @file_name_and_details_in_a_row_result =
      "total 24\ndrwxr-xr-x  6 kekosh  staff  192 11 27 16:57 .\n" \
      "drwxr-xr-x  3 kekosh  staff   96 11 23 20:38 for_test\n" \
      "-rw-r--r--  1 kekosh  staff   58 11 24 19:11 test1.rb\n" \
      "-rw-r--r--  1 kekosh  staff   73 11 24 19:13 test2.rb\n" \
      '-rw-r--r--  1 kekosh  staff  211 11 27 16:57 test3.txt'
  end

  def test_should_return_filename_up_to_3_filename_in_a_row
    assert_equal @data_in_a_row_result, Show.new(@data_in_a_row).show_object_list
  end

  def test_should_return_filename_and_details
    assert_equal @file_name_and_details_in_a_row_result, Show.new(@data_list_option).show_object_detail
  end
end
