# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../content'

class ContentTest < Minitest::Test
  # -aオプション
  # ディレクトリ内の一般的なファイル、ディレクトリのリストを取得する
  def test_should_return_normal_contents_list
    no_options = { all: false, long: false, reverse: false }
    no_option_result = ['for_test', 'test1.rb', 'test2.rb', 'test3.txt']
    assert_equal no_option_result, Content.new(no_options).find_contents
  end

  # ディレクトリ内の全オブジェクトを取得する
  def test_should_return_all_contents_list
    option_all_only = { all: true, long: false, reverse: false }
    option_all_result = ['.', 'for_test', 'test1.rb', 'test2.rb', 'test3.txt']
    assert_equal option_all_result, Content.new(option_all_only).find_contents
  end

  # -rオプション
  # 名前の降順でディレクトリ内の オブジェクトリストを取得
  def test_should_return_find_contents_sorted_decending_by_name
    option_reverse_only = { all: false, long: false, reverse: true }
    no_option_result = ['for_test', 'test1.rb', 'test2.rb', 'test3.txt']
    assert_equal no_option_result.reverse, Content.new(option_reverse_only).find_contents
  end

  # ディレクトリ内全オブジェクトのリストを降順で取得
  def test_should_return_all_contents_list_sorted_decending_by_name
    option_all_reverse = { all: true, long: false, reverse: true }
    option_all_result = ['.', 'for_test', 'test1.rb', 'test2.rb', 'test3.txt']
    assert_equal option_all_result.reverse, Content.new(option_all_reverse).find_contents
  end
end
