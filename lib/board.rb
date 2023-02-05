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
      ----+----+----+----+----+----+----
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
    horizontal_win? ||
      vertical_win? ||
      diagonal_win? ||
      antediagonal_win?
  end

  def horizontal_win?(array = @cells)
    row, _column = @last_move

    short_block = array[row].each_cons(4).find { |a| a.uniq.size == 1 && a.first != '.' }
    return short_block.first unless short_block.nil?
  end

  def vertical_win?
    # transpose the grid and apply the same algotihm used in horizontal check
    transposed = @cells.transpose
    horizontal_win?(transposed)
  end

  def diagonal_win?
    diagonal_arr = diagonals
    horizontal_win?(diagonal_arr)
  end

  def antediagonal_win?
    ante_diagonal_arr = antediagonals
    horizontal_win?(ante_diagonal_arr)
  end

  def diagonals
    # the first part obtains all diagonals with >= 4 entries originating from column 0.
    (0..@cells.size - 4).map do |i|
      (0..@cells.size - 1 - i).map { |j| @cells[i + j][j] }
      # the second part picks up the remaining diagonals originating from row 0.
    end.concat((1..@cells.first.size - 4).map do |j|
      (0..@cells.size - j - 1).map { |i| @cells[i][j + i] }
    end)
  end

  def antediagonals
    # By reversing the nested array I can recycle the diagonal_win? logic
    reverse = []
    @cells.each do |row|
      reverse << row.reverse
    end

    # the first part obtains all diagonals with >= 4 entries originating from column 0.
    (0..reverse.size - 4).map do |i|
      (0..reverse.size - 1 - i).map { |j| reverse[i + j][j] }
      # the second part picks up the remaining diagonals originating from row 0.
    end.concat((1..reverse.first.size - 4).map do |j|
      (0..reverse.size - j - 1).map { |i| reverse[i][j + i] }
    end)
  end
end
