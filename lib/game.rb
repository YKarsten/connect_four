# frozen_string_literal: true

require_relative 'display'

# Contains the logic to play the game
class Game
  include Display
  attr_reader :first_player, :second_player, :board, :current_player

  def initialize
    @board = Board.new
    @first_player = nil
    @second_player = nil
    @current_player = nil
  end

  def play
    game_set_up
    board.show
    player_turns
    conclusion
  end

  def create_player(number, duplicate_symbol = nil)
    puts display_name_prompt(number)
    name = gets.chomp
    symbol = symbol_input(duplicate_symbol)
    Player.new(name, symbol)
  end

end