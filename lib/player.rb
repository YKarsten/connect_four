# frozen_string_literal: true

# Game need two players
class Player
  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end
end
