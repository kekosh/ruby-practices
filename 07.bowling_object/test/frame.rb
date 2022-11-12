# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../frame'

class FrameTest < Minitest::Test
  def setup
    @shot_point = 4
    @shot_half = 5
    @shot_strike = 10
    @shot_gatter = 0
  end

  def test_return_frame_score
    # nomal frame
    assert_equal 9, Frame.new(@shot_point, @shot_half).score
    # gatter frame
    assert_equal 4, Frame.new(@shot_point, @shot_gatter).score
    # strke frame
    assert_equal 30, Frame.new(@shot_strike, @shot_strike, @shot_strike).score
    # spare frame
    assert_equal 14, Frame.new(@shot_half, @shot_half, @shot_point).score
  end
end
