# frozen_string_literal: true

# 6x7 grid of cells for connect 4.
# Holds methods to check valid inputs and display changes to the grid and determine game over
class Board
  attr_reader :cells

  # 6 row x 7 column grid
  def initialize
    @cells = (1..42).to_a
  end

  # rubocop:disable Metrics/AbcSize
  def show
    puts <<-HEREDOC

       #{cells[0]} | #{cells[1]} | #{cells[2]} | #{cells[3]} | #{cells[4]} | #{cells[5]} | #{cells[6]}
      ---+---+---+---+---+---+---
       #{cells[7]} | #{cells[8]} | #{cells[9]} | #{cells[10]} | #{cells[11]} | #{cells[12]} | #{cells[13]}
      ---+---+---+---+---+---+---
       #{cells[14]} | #{cells[15]} | #{cells[16]} | #{cells[17]} | #{cells[18]} | #{cells[19]} | #{cells[20]}
      ---+---+---+---+---+---+---
       #{cells[21]} | #{cells[22]} | #{cells[23]} | #{cells[24]} | #{cells[25]} | #{cells[26]} | #{cells[27]}
      ---+---+---+---+---+---+---
       #{cells[28]} | #{cells[29]} | #{cells[30]} | #{cells[31]} | #{cells[32]} | #{cells[33]} | #{cells[34]}
      ---+---+---+---+---+---+---
       #{cells[35]} | #{cells[36]} | #{cells[37]} | #{cells[38]} | #{cells[39]} | #{cells[40]} | #{cells[41]}
      ---+---+---+---+---+---+---
    HEREDOC
  end
  # rubocop:enable Metrics/AbcSize

  def update_board(number, color)
    @cells[number] = color
  end

  def valid_move?(number)
    # is number within the 6x7 grid?
    # is the index position filled with a color?
    cells[number - 1] == number
  end

  def full?
    # all cells no longer numbers?
    cells.all? { |cell| cell =~ /[^0-42]/ }
  end

  def game_over?
    # hard coding all winning formations is too much
  end
end
