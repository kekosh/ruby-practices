# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../information'

class InformationTest < Minitest::Test
  def test_should_return_list_files_in_the_long_format
    option_has_list_is_false = { all: false, list: false, reverse: false }
    no_option_result = [24, [
      'drwxr-xr-x  3 kekosh  staff   96 11 23 20:38 for_test',
      '-rw-r--r--  1 kekosh  staff   58 11 24 19:11 test1.rb',
      '-rw-r--r--  1 kekosh  staff   73 11 24 19:13 test2.rb',
      '-rw-r--r--  1 kekosh  staff  211 11 27 16:57 test3.txt'
    ]]
    assert_equal no_option_result, Information.new(option_has_list_is_false).list_contents_in_the_long_format
  end

  def test_should_rerturn_list_contents_in_the_long_format
    option_all_result = [24, [
      'drwxr-xr-x  6 kekosh  staff  192 11 27 16:57 .',
      'drwxr-xr-x  3 kekosh  staff   96 11 23 20:38 for_test',
      '-rw-r--r--  1 kekosh  staff   58 11 24 19:11 test1.rb',
      '-rw-r--r--  1 kekosh  staff   73 11 24 19:13 test2.rb',
      '-rw-r--r--  1 kekosh  staff  211 11 27 16:57 test3.txt'
    ]]
    option_has_list_is_true = { all: true, list: true, reverse: false }
    assert_equal option_all_result, Information.new(option_has_list_is_true).list_contents_in_the_long_format
  end
end
