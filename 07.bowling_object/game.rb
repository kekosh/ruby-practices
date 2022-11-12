# frozen_string_literal: true

require_relative './frame'
require_relative './shot'

class Game
  def initialize(game_score)
    @game_score = game_score
  end

  def score
    total = 0
    return_score_list_by_frames.each do |frame_score|
      total += Frame.new(*frame_score).score
    end
    total
  end

  private

  def return_score_list_by_frames
    shots = @game_score.split(',').map { |shot| Shot.new(shot).score }
    divide_into_frame(shots)
  end

  def divide_into_frame(shots)
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
