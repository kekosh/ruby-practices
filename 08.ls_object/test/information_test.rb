# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../information'

class InformationTest < Minitest::Test
  def setup
    @no_option_list = ['for_test', 'test1.rb', 'test2.rb']
    @option_all_list = ['.', 'for_test', 'test1.rb', 'test2.rb']

    @no_option_result = [16, [
      'drwxr-xr-x  3 kekosh  staff  96 11 23 20:38 for_test',
      '-rw-r--r--  1 kekosh  staff  58 11 24 19:11 test1.rb',
      '-rw-r--r--  1 kekosh  staff  73 11 24 19:13 test2.rb'
    ]]

    @option_all_result = [16, [
      'drwxr-xr-x  5 kekosh  staff  160 11 23 20:37 .',
      'drwxr-xr-x  3 kekosh  staff   96 11 23 20:38 for_test',
      '-rw-r--r--  1 kekosh  staff   58 11 24 19:11 test1.rb',
      '-rw-r--r--  1 kekosh  staff   73 11 24 19:13 test2.rb'
    ]]
  end

  def test_should_return_file_detail_and_permission
    assert_equal @no_option_result, Information.new(@no_option_list).return_detail_info_and_permissions
  end

  def test_should_rerturn_directory_detail_and_permission
    assert_equal @option_all_result, Information.new(@option_all_list).return_detail_info_and_permissions
  end
end
