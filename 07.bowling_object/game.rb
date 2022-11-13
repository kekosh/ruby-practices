# frozen_string_literal: true

require_relative './frame'
require_relative './shot'

class Game
  def initialize(shots)
    @shots = shots
  end

  def score
    total = 0
    return_point_list_by_frames.each do |point_list|
      total += Frame.new(*point_list).score_by_frame
    end
    total
  end

  private

  def return_point_list_by_frames
    points = @shots.split(',').map { |shot| Shot.new(shot).convert_to_point }

    temp = []
    point_list_by_frames = []
    points.each_with_index do |point, index|
      break if point_list_by_frames.size == 10

      temp.push(point)
      if temp.size == 1 && point == 10
        temp = [].concat(temp, points.slice(index + 1, 2))
        point_list_by_frames.push(temp)
        temp = []
      end

      next unless temp.size == 2

      temp.push(points[index + 1]) if temp.sum == 10
      point_list_by_frames.push(temp)
      temp = []
    end
    point_list_by_frames
  end
end
