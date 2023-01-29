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
      allow(game).to receive(:game_set_up)
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
      allow(game).to receive (:puts)
      allow(game).to receive(:display_name_prompt). with(1)
      allow(game).to receive(:gets).and_return(player_name)
      allow(game).to receive(:symbol_input).and_return(player_color)
      expect(Player).to receive(:new).with(player_name, player_color)
      game.create_player(1)
    end
  end
  # class end
end