# frozen_string_literal: true

require 'minitest/autorun'

class Shot
  def initialize(shot)
    @shot = shot
  end

  def score
    @shot == 'X' ? 10 : @shot.to_i
  end
end

class ShotTest < Minitest::Test
  def setup
    @shot_point = '5'
    @shot_gatter = '0'
    @shot_strike = 'X'
  end

  def test_return_score
    assert_equal 5, Shot.new(@shot_point).score
    assert_equal 0, Shot.new(@shot_gatter).score
    assert_equal 10, Shot.new(@shot_strike).score
  end
end
