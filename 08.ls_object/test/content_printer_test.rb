# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../content_printer'

class PrintTest < Minitest::Test
  def test_should_print_file_name_list
    no_options = { all: false, long: false, reverse: false }
    no_options_result = "for_test \t\ttest2.rb \ntest1.rb \t\ttest3.txt"
    assert_equal no_options_result, ContentPrinter.new(no_options).contents_list
  end

  def test_should_print_all_contents_list
    option_all_only = { all: true, long: false, reverse: false }
    option_all_only_result = ".        \t\ttest1.rb \t\ttest3.txt\nfor_test \t\ttest2.rb"
    assert_equal option_all_only_result, ContentPrinter.new(option_all_only).contents_list
  end

  def test_should_print_file_name_on_long_format
    option_list_only = { all: false, long: true, reverse: false }
    option_list_only_result =
      "total 24\n" \
      "drwxr-xr-x  3 kekosh  staff   96 11 23 20:38 for_test\n" \
      "-rw-r--r--  1 kekosh  staff   58 11 24 19:11 test1.rb\n" \
      "-rw-r--r--  1 kekosh  staff   73 11 24 19:13 test2.rb\n" \
      '-rw-r--r--  1 kekosh  staff  211 11 27 16:57 test3.txt'
    assert_equal option_list_only_result, ContentPrinter.new(option_list_only).contents_list
  end

  def test_should_print_file_name_list_by_reverse_sort
    option_reverse_only = { all: false, long: false, reverse: true }
    option_reverse_only_result = "test3.txt\t\ttest1.rb \ntest2.rb \t\tfor_test"
    assert_equal option_reverse_only_result, ContentPrinter.new(option_reverse_only).contents_list
  end

  def test_should_print_all_contents_list_on_long_format
    option_all_and_list = { all: true, long: true, reverse: false }
    option_all_and_list_result =
      "total 24\n" \
      "drwxr-xr-x  6 kekosh  staff  192 11 27 16:57 .\n" \
      "drwxr-xr-x  3 kekosh  staff   96 11 23 20:38 for_test\n" \
      "-rw-r--r--  1 kekosh  staff   58 11 24 19:11 test1.rb\n" \
      "-rw-r--r--  1 kekosh  staff   73 11 24 19:13 test2.rb\n" \
      '-rw-r--r--  1 kekosh  staff  211 11 27 16:57 test3.txt'
    assert_equal option_all_and_list_result, ContentPrinter.new(option_all_and_list).contents_list
  end

  def test_should_print_all_contents_list_by_reverse_sort
    option_all_and_reverse = { all: true, long: false, reverse: true }
    option_all_and_reverse_result = "test3.txt\t\ttest1.rb \t\t.        \ntest2.rb \t\tfor_test"
    assert_equal option_all_and_reverse_result, ContentPrinter.new(option_all_and_reverse).contents_list
  end

  def test_should_print_contents_list_on_all_options_are_true
    all_options_turned_on = { all: true, long: true, reverse: true }
    all_options_are_turned_on_result =
      "total 24\n" \
      "-rw-r--r--  1 kekosh  staff  211 11 27 16:57 test3.txt\n" \
      "-rw-r--r--  1 kekosh  staff   73 11 24 19:13 test2.rb\n" \
      "-rw-r--r--  1 kekosh  staff   58 11 24 19:11 test1.rb\n" \
      "drwxr-xr-x  3 kekosh  staff   96 11 23 20:38 for_test\n" \
      'drwxr-xr-x  6 kekosh  staff  192 11 27 16:57 .'
    assert_equal all_options_are_turned_on_result, ContentPrinter.new(all_options_turned_on).contents_list
  end
end
