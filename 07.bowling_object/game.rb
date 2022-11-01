# frozen_string_literal: true

require 'minitest/autorun'
require_relative './frame'
require_relative './shot'

class Game
  def initialize(game_score)
    @game_score = game_score
  end

  def score_list_by_frame
    shots = @game_score.split(',').map { |shot| Shot.new(shot).score }
    @score_frames = divied_into_frame(shots)
  end

  private

  def divied_into_frame(shots)
    temp = []
    frames = []
    shots.each_with_index do |shot, index|
      break if frames.size == 10

      temp.push(shot)
      if temp.size == 1 && shot == 10
        temp = [].concat(temp, shots.slice(index + 1, 2))
        frames.push(temp)
        temp = []
      end

      next unless temp.size == 2

      temp.push(shots[index + 1]) if temp.sum == 10
      frames.push(temp)
      temp = []
    end
    frames
  end
end

class GameTest < Minitest::Test
  def setup
    @game_score_1st = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5' # 139
    @game_score_2nd = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X' # 164
    @game_score_3rd = '0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4' # 107
    @game_score_4th = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0' # 134
    @game_score_5th = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8' # 144
    @game_score_6th = 'X,X,X,X,X,X,X,X,X,X,X,X' # 300
  end

  def test_should_return_frame_list
    premise_score_array = [[6, 3], [9, 0], [0, 3], [8, 2, 7], [7, 3, 10], [10, 9, 1], [9, 1, 8], [8, 0], [10, 6, 4], [6, 4, 5]]
    assert_equal premise_score_array, Game.new(@game_score_1st).score_list_by_frame

    premise_score_array = [[6, 3], [9, 0], [0, 3], [8, 2, 7], [7, 3, 10], [10, 9, 1], [9, 1, 8], [8, 0], [10, 10, 10], [10, 10, 10]]
    assert_equal premise_score_array, Game.new(@game_score_2nd).score_list_by_frame

    premise_score_array = [[0, 10, 1], [1, 5], [0, 0], [0, 0], [10, 10, 10], [10, 10, 5], [10, 5, 1], [5, 1], [8, 1], [0, 4]]
    assert_equal premise_score_array, Game.new(@game_score_3rd).score_list_by_frame

    premise_score_array = [[6, 3], [9, 0], [0, 3], [8, 2, 7], [7, 3, 10], [10, 9, 1], [9, 1, 8], [8, 0], [10, 10, 0], [10, 0, 0]]
    assert_equal premise_score_array, Game.new(@game_score_4th).score_list_by_frame

    premise_score_array = [[6, 3], [9, 0], [0, 3], [8, 2, 7], [7, 3, 10], [10, 9, 1], [9, 1, 8], [8, 0], [10, 10, 1], [10, 1, 8]]
    assert_equal premise_score_array, Game.new(@game_score_5th).score_list_by_frame

    premise_score_array = [[10, 10, 10], [10, 10, 10], [10, 10, 10], [10, 10, 10], [10, 10, 10], [10, 10, 10], [10, 10, 10], [10, 10, 10], [10, 10, 10],
                           [10, 10, 10]]
    assert_equal premise_score_array, Game.new(@game_score_6th).score_list_by_frame
  end
end
