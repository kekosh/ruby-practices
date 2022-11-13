# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../shot'

class ShotTest < Minitest::Test
  def setup
    @shot_point = '5'
    @shot_gatter = '0'
    @shot_strike = 'X'
  end

  def test_return_score
    assert_equal 5, Shot.new(@shot_point).convert_to_point
    assert_equal 0, Shot.new(@shot_gatter).convert_to_point
    assert_equal 10, Shot.new(@shot_strike).convert_to_point
  end
end
