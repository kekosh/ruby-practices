# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../objects'

class ObjectsTest < Minitest::Test

  # -aオプション
  # ディレクトリ内の一般的なファイル、ディレクトリのリストを取得する
  def test_should_return_normal_objects_list
    no_options = { all: false, list: false, reverse: false }
    no_option_result = ['for_test', 'test1.rb', 'test2.rb', 'test3.txt']
    assert_equal no_option_result, Objects.new(no_options).object_list
  end

  # ディレクトリ内の全オブジェクトを取得する
  def test_should_return_all_objects_list
    option_all_only = { all: true, list: false, reverse: false }
    option_all_result = ['.', 'for_test', 'test1.rb', 'test2.rb', 'test3.txt']
    assert_equal option_all_result, Objects.new(option_all_only).object_list
  end

  # -rオプション
  # 名前の降順でディレクトリ内の オブジェクトリストを取得
  def test_should_return_object_list_sorted_decending_by_name
    option_reverse_only = { all: false, list: false, reverse: true }
    no_option_result = ['for_test', 'test1.rb', 'test2.rb', 'test3.txt']
    assert_equal no_option_result.reverse, Objects.new(option_reverse_only).object_list
  end

  # ディレクトリ内全オブジェクトのリストを降順で取得
  def test_should_return_all_objects_list_sorted_decending_by_name
    option_all_reverse = { all: true, list: false, reverse: true }
    option_all_result = ['.', 'for_test', 'test1.rb', 'test2.rb', 'test3.txt']
    assert_equal option_all_result.reverse, Objects.new(option_all_reverse).object_list
  end
end
