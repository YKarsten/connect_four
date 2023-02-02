# frozen_string_literal: true

# 6x7 grid of cells for connect 4.
# Holds methods to check valid inputs and display changes to the grid and determine game over
class Board
  attr_reader :cells

  # 6 row x 7 column grid
  def initialize
    @cells = Array.new(6) { Array.new(7) }
    @last_move = []
  end

  # rubocop:disable Metrics/AbcSize
  def show
    puts <<-HEREDOC

       #{cells[0][0]} | #{cells[0][1]} | #{cells[0][2]} | #{cells[0][3]} | #{cells[0][4]} | #{cells[0][5]} | #{cells[0][6]}
      ---+---+---+---+---+---+---
       #{cells[1][0]} | #{cells[1][1]} | #{cells[1][2]} | #{cells[1][3]} | #{cells[1][4]} | #{cells[1][5]} | #{cells[1][6]}
      ---+---+---+---+---+---+---
       #{cells[2][0]} | #{cells[2][1]} | #{cells[2][2]} | #{cells[2][3]} | #{cells[2][4]} | #{cells[2][5]} | #{cells[2][6]}
      ---+---+---+---+---+---+---
       #{cells[3][0]} | #{cells[3][1]} | #{cells[3][2]} | #{cells[3][3]} | #{cells[3][4]} | #{cells[3][5]} | #{cells[3][6]}
      ---+---+---+---+---+---+---
       #{cells[4][0]} | #{cells[4][1]} | #{cells[4][2]} | #{cells[4][3]} | #{cells[4][4]} | #{cells[4][5]} | #{cells[4][6]}
      ---+---+---+---+---+---+---
       #{cells[5][0]} | #{cells[5][1]} | #{cells[5][2]} | #{cells[5][3]} | #{cells[5][4]} | #{cells[5][5]} | #{cells[5][6]}
      ---+---+---+---+---+---+---
    HEREDOC
  end
  # rubocop:enable Metrics/AbcSize

  def update_board(number, color)
    # put the token in the column's first empty space from the bottom
    target_row = cells.map.with_index { |row, index| row[number].nil? ? index : nil }.compact.max
    @cells[target_row][number] = color
    @last_move = [target_row, number]
  end

  def valid_move?(number)
    # Does input correspond to a valid column and is this column not full?
    (0..6).to_a.include?(number) && @cells[0][number] == nil
  end

  def full?
    @cells.flatten.none?(&:nil?)
  end

  def game_over?
    row, column = @last_move

    # horizontal win
    @cells[row][column] && @cells[row][column + 1] && @cells[row][column + 2] == @cells[row][column + 3] ||
      @cells[row][column] && @cells[row][column - 1] && @cells[row][column - 2] == @cells[row][column - 3] ||

      # vertical win
      @cells[row][column] && @cells[row + 1][column] && @cells[row + 2][column] == @cells[row + 3][column] ||
      # # diagonal win
      @cells[row][column] && @cells[row + 1][column + 1] && @cells[row + 2][column + 2] == @cells[row + 3][column + 3] ||
      @cells[row][column] && @cells[row - 1][column - 1] && @cells[row - 2][column - 2] == @cells[row - 2][column - 3]
  end
end
