# frozen_string_literal: true

require_relative '../lib/tic_tac_toe.rb'

describe Board do
  let(:player1) { instance_double(Player) }
  let(:player2) { instance_double(Player) }

  before do
    allow(player1).to receive(:symbol).and_return('x')
    allow(player2).to receive(:symbol).and_return('o')
  end

  context '#check' do
    context 'player1 won the game via top row' do
      game_layout = [['x', 'x', 'x'], [4, 5, 6], [7, 8, 9]]
      subject(:won_game) { described_class.new(game_layout) }

      it 'player1 check returns true' do
        expect(won_game.check(player1)).to eq(true)
      end

      it 'player2 check returns false' do
        expect(won_game.check(player2)).to eq(false)
      end
    end

    context 'player1 won the game via diagonal victory' do
      game_layout = [['x', 'o', 'o'], ['o', 'x', 'o'], ['o', 'o', 'x']]
      subject(:won_game) { described_class.new(game_layout) }

      it 'player1 check returns true' do
        expect(won_game.check(player1)).to eq(true)
      end

      it 'player2 check returns false' do
        expect(won_game.check(player2)).to eq(false)
      end
    end
  end

  context '#start' do
    # Loop script, have to chek all methods inside, and that it loops correct
    # amount of times
    subject(:new_game) {described_class.new}

    before do
      allow(new_game).to receive(:draw)
      allow(new_game).to receive(:winner)
    end

    context 'loops once' do
      before do
        allow(new_game).to receive(:play).and_return(true)
      end
      it 'calls draw and winner once if player1 has won' do
        expect(new_game).to receive(:draw).once
        expect(new_game).to receive(:winner).once

        new_game.start(player1, player2)
      end
    end
    context 'loops once calls second player' do
      before do
        allow(new_game).to receive(:play).and_return(false, true)
      end
      it 'calls draw, winner once and play twice if player2 won' do
        expect(new_game).to receive(:draw).once
        expect(new_game).to receive(:play).twice
        expect(new_game).to receive(:winner).once
        new_game.start(player1, player2)
      end
    end
    context 'loops twice' do
      before do
        allow(new_game).to receive(:play).and_return(false, false, true)
      end
      it 'calls play thrice, draw and winner once' do
        expect(new_game).to receive(:draw).once
        expect(new_game).to receive(:play).thrice
        expect(new_game).to receive(:winner).once
        new_game.start(player1, player2)
      end
    end
  end
  context '#winner' do
    subject(:game_won) { described_class.new }

    before do
      allow(game_won).to receive(:start)
      allow(player1).to receive(:name).and_return('player1')
      allow(game_won).to receive(:puts)
    end

    it 'restarts the game when Y is received from player' do
      allow(game_won).to receive(:gets).and_return('Y')
      expect(game_won).to receive(:start).once
      game_won.winner(player1, player2)
    end

    it 'does not restart game when N is received from player' do
      allow(game_won).to receive(:gets).and_return('N')
      expect(game_won).not_to receive(:start)
      game_won.winner(player1, player2)
    end

  end
end
