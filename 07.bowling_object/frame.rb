# frozen_string_literal: true

require_relative './shot'

class Frame
  def initialize(first_shot, second_shot, third_shot = 0)
    @first_shot = first_shot
    @second_shot = second_shot
    @third_shot = third_shot
  end

  def score_by_frame
    @first_shot + @second_shot + @third_shot
  end
end
