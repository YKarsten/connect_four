# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'

# rubocop:disable Metrics/BlockLength

describe Game do
  subject(:game) { described_class.new }

  before do
    game.instance_variable_set(:@board, instance_double(Board))
  end

  describe '#play' do
    it 'shows the board' do
      allow(game).to receive(:game_setup)
      allow(game).to receive(:player_turns)
      allow(game).to receive(:conclusion)
      expect(game.board).to receive(:show)
      game.play
    end
  end

  describe '#create_player' do
    it 'creates player #1' do
      player_name = 'Yannik'
      player_color = 'red'
      allow(game).to receive(:puts)
      allow(game).to receive(:display_name_prompt).with(1)
      allow(game).to receive(:gets).and_return(player_name)
      allow(game).to receive(:symbol_input).and_return(player_color)
      expect(Player).to receive(:new).with(player_name, player_color)
      game.create_player(1)
    end
  end

  describe '#turn' do
    it 'updates the board' do
      game.instance_variable_set(:@first_player, instance_double(Player))
      player_color = 'red'
      player_input = 5
      allow(game.first_player).to receive(:color).and_return(player_color)
      allow(game).to receive(:turn_input).with(game.first_player).and_return(player_input)
      allow(game.board).to receive(:show)
      expect(game.board).to receive(:update_board).with(player_input, player_color)
      game.turn(game.first_player)
    end
  end
  # class end
end
# rubocop:enable Metrics/BlockLength
