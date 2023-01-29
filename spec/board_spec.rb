# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }

  describe '#update_board' do
    context 'when board is new' do
      it 'updates cells[index]' do
        player_input = 0
        player_color = 'T'
        board.update_board(player_input, player_color)
        updated_board = board.cells
        updated_index_zero = ['T'] + (2..42).to_a
        expect(updated_board).to eq(updated_index_zero)
      end
    end

    context 'when the board has been used' do
      before do
        board.instance_variable_set(:@cells, [1, 2, 3, 'T', 'W', 6, 7, 'W', 9, 10,
                                              11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
                                              21, 'T', 23, 24, 'T', 26, 27, 'T', 29, 30,
                                              31, 32, 33, 'W', 35, 36, 37, 38, 39, 40,
                                              41, 42])
      end

      it 'updates cells[index]' do
        # player input is an index for cells array
        player_input = 5
        player_color = 'W'
        board.update_board(player_input, player_color)
        updated_board = board.cells
        updated_index_three = [1, 2, 3, 'T', 'W', 'W', 7, 'W', 9, 10,
                               11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
                               21, 'T', 23, 24, 'T', 26, 27, 'T', 29, 30,
                               31, 32, 33, 'W', 35, 36, 37, 38, 39, 40,
                               41, 42]
        expect(updated_board).to eq(updated_index_three)
      end
    end
    # describe #method end
  end
end

describe Board do
  subject(:board) { described_class.new }

  describe '#valid_move?' do
    context 'when board is new' do
      it 'is a valid move' do
        player_move = board.valid_move?(4)
        expect(player_move).to be(true)
      end
    end

    context 'when choosing a cell that is open' do
      before do
        board.instance_variable_set(:@cells, [1, 2, 3, 'T', 'W', 'W', 7, 'W', 9, 10,
                                              11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
                                              21, 'T', 23, 24, 'T', 26, 27, 'T', 29, 30,
                                              31, 32, 33, 'W', 35, 36, 37, 38, 39, 40,
                                              41, 42])
      end
      it 'is a valid move' do
        open_move = board.valid_move?(9)
        expect(open_move).to be true
      end
    end

    context 'when choosing a cell that is occupied' do
      before do
        board.instance_variable_set(:@cells, [1, 2, 3, 'T', 'W', 'W', 7, 'W', 9, 10,
                                              11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
                                              21, 'T', 23, 24, 'T', 26, 27, 'T', 29, 30,
                                              31, 32, 33, 'W', 35, 36, 37, 38, 39, 40,
                                              41, 42])
      end
      it 'is an invalid move' do
        invalid_move = board.valid_move?(5)
        expect(invalid_move).not_to be true
      end
    end
    # describe #method end
  end
end

describe Board do
  subject(:board) { described_class.new }

  describe '#full?' do
    context 'when board is new' do
      it 'is not full' do
        expect(board).not_to be_full
      end
    end

    context 'when the board is partially filled' do
      before do
        board.instance_variable_set(:@cells, [1, 2, 3, 'T', 'W', 'W', 7, 'W', 9, 10,
                                              11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
                                              21, 'T', 23, 24, 'T', 26, 27, 'T', 29, 30,
                                              31, 32, 33, 'W', 35, 36, 37, 38, 39, 40,
                                              41, 42])
      end
      it 'is not full' do
        expect(board).not_to be_full
      end
    end

    context 'when the board is completely full' do
      before do
        board.instance_variable_set(:@cells, Array.new(5) { 'W' })
      end
      it 'is full' do
        expect(board).to be_full
      end
    end
    # describe #method end
  end
end

describe Board do
  subject(:board) { described_class.new }

  describe '#game_over?' do
    context 'when board is new' do
      it 'is not game over' do
        expect(board).not_to be_game_over
      end
    end

    context 'when board is sparsely filled' do
      before do
        board.instance_variable_set(:@cells, [1, 2, 3, 'T', 'W', 'W', 7, 'W', 9, 10,
                                              11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
                                              21, 'T', 23, 24, 'T', 26, 27, 'T', 29, 30,
                                              31, 32, 33, 'W', 35, 36, 37, 38, 39, 40,
                                              41, 42])
      end
      it 'is not game over' do
        expect(board).not_to be_game_over
      end
    end

    context 'When a player has connect four horizonatlly' do
      before do
        board.instance_variable_set(:@cells, ['T', 'T', 'T', 'T', 'W', 'W', 7, 'W', 9, 10,
                                              11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
                                              21, 'T', 23, 24, 'T', 26, 27, 'T', 29, 30,
                                              31, 32, 33, 'W', 35, 36, 37, 38, 39, 40,
                                              41, 42])
      end
      it 'is game over' do
        expect(board).to be_game_over
      end
    end
    # describe #method end
  end
  # describe Board end
end

# rubocop:enable Metrics/BlockLength
