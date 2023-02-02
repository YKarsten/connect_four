# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }

  describe '#update_board' do
    context 'when board is new' do
      it 'updates cells[index]' do
        player_input = 1
        player_color = 'T'
        board.update_board(player_input, player_color)
        updated_board = board.cells
        updated_index_zero = Array.new(6) { Array.new(7) }
        updated_index_zero[5][1] = 'T'
        expect(updated_board).to eq(updated_index_zero)
      end
    end

    context 'when the board has been used' do
      before do
        board.instance_variable_set(:@cells, [[nil, nil, nil, nil, nil, nil, nil],
                                              [nil, nil, nil, nil, nil, nil, nil],
                                              [nil, nil, nil, nil, nil, nil, nil],
                                              [nil, nil, nil, nil, nil, nil, nil],
                                              [nil, nil, nil, nil, nil, 'red', nil],
                                              [nil, nil, nil, nil, nil, 'red', nil]])
      end

      it 'updates cells[index]' do
        # player input is an index for cells array
        player_input = 5
        player_color = 'W'
        board.update_board(player_input, player_color)
        updated_board = board.cells
        updated_index_three = [[nil, nil, nil, nil, nil, nil, nil],
                               [nil, nil, nil, nil, nil, nil, nil],
                               [nil, nil, nil, nil, nil, nil, nil],
                               [nil, nil, nil, nil, nil, 'W', nil],
                               [nil, nil, nil, nil, nil, 'red', nil],
                               [nil, nil, nil, nil, nil, 'red', nil]]
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

    context 'when choosing a column that is open' do
      before do
        board.instance_variable_set(:@cells, [[nil, nil, nil, nil, nil, nil, nil],
                                              [nil, nil, nil, nil, nil, nil, nil],
                                              [nil, nil, nil, nil, nil, nil, nil],
                                              [nil, nil, nil, nil, nil, 'W', nil],
                                              [nil, nil, nil, nil, nil, 'red', nil],
                                              [nil, nil, nil, nil, nil, 'red', nil]])
      end
      it 'is a valid move' do
        open_move = board.valid_move?(5)
        expect(open_move).to be true
      end
    end

    context 'when choosing a column that is occupied' do
      before do
        board.instance_variable_set(:@cells, [[nil, nil, nil, nil, nil, 'blue', nil],
                                              [nil, nil, nil, nil, nil, 'red', nil],
                                              [nil, nil, nil, nil, nil, 'blue', nil],
                                              [nil, nil, nil, nil, nil, 'blue', nil],
                                              [nil, nil, nil, nil, nil, 'red', nil],
                                              [nil, nil, nil, nil, nil, 'red', nil]])
      end
      it 'is an invalid move' do
        invalid_move = board.valid_move?(5)
        expect(invalid_move).to be false
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
        board.instance_variable_set(:@cells, [[nil, nil, nil, nil, nil, 'blue', nil],
                                              [nil, nil, nil, nil, nil, 'red', nil],
                                              [nil, nil, nil, nil, nil, 'blue', nil],
                                              [nil, nil, nil, nil, nil, 'blue', nil],
                                              [nil, nil, nil, nil, nil, 'red', nil],
                                              [nil, nil, nil, nil, nil, 'red', nil]])
      end
      it 'is not full' do
        expect(board).not_to be_full
      end
    end

    context 'when the board is completely full' do
      before do
        board.instance_variable_set(:@cells, [['red', 'red', 'red', 'red', 'red', 'red', 'red'],
                                              ['red', 'red', 'red', 'red', 'red', 'red', 'red'],
                                              ['red', 'red', 'red', 'red', 'red', 'red', 'red'],
                                              ['red', 'red', 'red', 'red', 'red', 'red', 'red'],
                                              ['red', 'red', 'red', 'red', 'red', 'red', 'red'],
                                              ['red', 'red', 'red', 'red', 'red', 'red', 'red']])
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
      before do
        board.instance_variable_set(:@last_move, [0, 0])
      end
      it 'is not game over' do
        expect(board).not_to be_game_over
      end
    end

    context 'when board is sparsely filled' do
      before do
        board.instance_variable_set(:@last_move, [0, 0])
        board.instance_variable_set(:@cells, [[nil, nil, nil, nil, nil, 'blue', nil],
                                              [nil, nil, nil, nil, nil, 'red', nil],
                                              [nil, nil, nil, nil, nil, 'blue', nil],
                                              [nil, nil, nil, nil, nil, 'blue', nil],
                                              [nil, nil, nil, nil, nil, 'red', nil],
                                              [nil, nil, nil, nil, nil, 'red', nil]])
      end
      it 'is not game over' do
        expect(board).not_to be_game_over
      end
    end

    context 'When a player has connect four horizontally' do
      before do
        board.instance_variable_set(:@last_move, [0, 0])
        board.instance_variable_set(:@cells, [['red', 'red', 'red', 'red', nil, nil, nil],
                                              [nil, nil, nil, nil, nil, nil, nil],
                                              [nil, nil, nil, nil, nil, nil, nil],
                                              [nil, nil, nil, nil, nil, nil, nil],
                                              [nil, nil, nil, nil, nil, nil, nil],
                                              [nil, nil, nil, nil, nil, nil, nil]])
      end
      it 'is game over' do
        expect(board).to be_game_over
      end
    end

    context 'When a player has connect four vertically' do
      before do
        board.instance_variable_set(:@last_move, [0, 0])
        board.instance_variable_set(:@cells, [['red', nil, nil, nil, nil, nil, nil],
                                              ['red', nil, nil, nil, nil, nil, nil],
                                              ['red', nil, nil, nil, nil, nil, nil],
                                              ['red', nil, nil, nil, nil, nil, nil],
                                              [nil, nil, nil, nil, nil, nil, nil],
                                              [nil, nil, nil, nil, nil, nil, nil]])
      end
      it 'is game over' do
        expect(board).to be_game_over
      end
    end

    context 'When a player has connect four diagonally' do
      before do
        board.instance_variable_set(:@last_move, [0, 0])
        board.instance_variable_set(:@cells, [['red', nil, nil, nil, nil, nil, nil],
                                              [nil, 'red', nil, nil, nil, nil, nil],
                                              [nil, nil, 'red', nil, nil, nil, nil],
                                              [nil, nil, nil, 'red', nil, nil, nil],
                                              [nil, nil, nil, nil, nil, nil, nil],
                                              [nil, nil, nil, nil, nil, nil, nil]])
      end
      it 'is game over' do
        expect(board).to be_game_over
      end
    end

    context 'When a player has connect four diagonally' do
      before do
        board.instance_variable_set(:@last_move, [5, 3])
        board.instance_variable_set(:@cells, [[nil, nil, nil, nil, nil, nil, nil],
                                              [nil, nil, nil, nil, nil, nil, nil],
                                              [nil, nil, nil, nil, nil, nil, 'red'],
                                              [nil, nil, nil, nil, nil, 'red', nil],
                                              [nil, nil, nil, nil, 'red', nil, nil],
                                              [nil, nil, nil, 'red', nil, nil, nil]])
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
