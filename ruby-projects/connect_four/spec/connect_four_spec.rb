#frozen_string_literal: true

require_relative '../lib/connect_four.rb'

describe Board do
  let(:p1) { instance_double(Player) }
  let(:p2) { instance_double(Player) }
  before do
    allow(p1).to receive(:symbol).and_return("\u26AA")
  end

  context '#build_board' do
    subject(:standard_board) { described_class.new }
    it 'returns board of 7x6' do
      width = standard_board.instance_variable_get(:@width)
      height = standard_board.instance_variable_get(:@height)
      board = standard_board.build_board(width, height)
      expect(board.length).to eq(7)
      board.each { |col| expect(col.length).to eq(6) }
    end
  end

  context '#drop_token' do
    subject(:standard_board) { described_class.new }
    it 'drops the correct color token to the bottom of the first column' do
      layout = standard_board.instance_variable_get(:@layout)
      expect { standard_board.drop_token(p1, 0) }
        .to change { layout[0][5] }
        .to("\u26AA")
    end
    it 'drops two correct color tokens to the bottom of the first column' do
      layout = standard_board.instance_variable_get(:@layout)
      standard_board.drop_token(p1, 0)
      expect { standard_board.drop_token(p1, 0) }
        .to change { layout[0][4] }
        .to("\u26AA")
    end
    it 'drops a different color token on top of two tokens' do
      allow(p2).to receive(:symbol).and_return('U+2B24')
      layout = standard_board.instance_variable_get(:@layout)
      standard_board.drop_token(p1, 0)
      standard_board.drop_token(p1, 0)
      expect { standard_board.drop_token(p2, 0) }
        .to change { layout[0][3] }
        .to('U+2B24')
    end
    it 'returns nil when col full' do
      allow(standard_board).to receive(:height).and_return(1)
      standard_board.drop_token(p1, 0)
      expect(standard_board.drop_token(p1, 0)).to eq(nil)
    end
  end

  context '#check_winner' do
    context 'game has not yet been won' do
      subject(:incomplete_game) { described_class.new }
      it 'returns false' do
        expect(incomplete_game.check_winner(p1)).to eq(false)
      end
    end
  end

  context '#check_down' do
    subject(:game) { described_class.new }
    context 'ties to check out of bounds' do
      it 'returns false' do
        allow(game).to receive(:height).and_return(1)
        expect(game.check_down(p1.symbol, 0, 0)).to eq(false)
      end
      it 'returns false' do
        allow(game).to receive(:height).and_return(3)
        allow(game).to receive(:layout).and_return([["\u26AA", "\u26AA", "\u26AA", "\u26AA"]])
        expect(game.check_down(p1.symbol, 0, 0)).to eq(false)
      end
    end
    context 'only first and last tokens match' do
      it 'returns false' do
        allow(game).to receive(:layout).and_return([["\u26AA", nil, nil, "\u26AA"]])
        expect(game.check_down(p1.symbol, 0, 0)).to eq(false)
      end
    end
    context '4 tokens match downwards' do
      it 'returns true' do
        allow(game).to receive(:layout).and_return([["\u26AA", "\u26AA", "\u26AA", "\u26AA"]])
        expect(game.check_down(p1.symbol, 0, 0)).to eq(true)
      end
    end
  end

  context '#check_right' do
    subject(:game) { described_class.new }
    context 'ties to check out of bounds' do
      it 'returns false' do
        allow(game).to receive(:width).and_return(1)
        expect(game.check_right(p1.symbol, 0, 0)).to eq(false)
      end
      it 'returns false' do
        allow(game).to receive(:width).and_return(3)
        allow(game).to receive(:layout).and_return([["\u26AA"], ["\u26AA"], ["\u26AA"], ["\u26AA"]])
        expect(game.check_down(p1.symbol, 0, 0)).to eq(false)
      end
    end
    context 'only first and last tokens match' do
      it 'returns false' do
        allow(game).to receive(:layout).and_return([["\u26AA"], [nil], [nil], ["\u26AA"]])
        expect(game.check_right(p1.symbol, 0, 0)).to eq(false)
      end
    end
    context '4 tokens match downwards' do
      it 'returns true' do
        allow(game).to receive(:layout).and_return([["\u26AA"], ["\u26AA"], ["\u26AA"], ["\u26AA"]])
        expect(game.check_right(p1.symbol, 0, 0)).to eq(true)
      end
    end
  end

  context '#check_diagonal_right' do
    subject(:game) { described_class.new }
    context 'ties to check out of bounds' do
      it 'returns false' do
        allow(game).to receive(:width).and_return(1)
        allow(game).to receive(:height).and_return(1)
        expect(game.check_diagonal_right(p1.symbol, 0, 0)).to eq(false)
      end
      it 'returns false' do
        allow(game).to receive(:width).and_return(3)
        expect(game.check_diagonal_right(p1.symbol, 0, 0)).to eq(false)
      end
    end
    context 'only first and last tokens match' do
      it 'returns false' do
        allow(game).to receive(:layout)
          .and_return([
            ["\u26AA", nil, nil, nil],
            [nil , nil, nil, nil],
            [nil, nil, nil, nil],
            [nil, nil, nil, "\u26AA"]
          ])
        expect(game.check_diagonal_right(p1.symbol, 0, 0)).to eq(false)
      end
    end
    context '4 tokens match diagonally right' do
      it 'returns true' do
        allow(game).to receive(:layout)
          .and_return([
            ["\u26AA", nil, nil, nil],
            [nil, "\u26AA", nil, nil],
            [nil, nil, "\u26AA", nil],
            [nil, nil, nil, "\u26AA"]
          ])
        expect(game.check_diagonal_right(p1.symbol, 0, 0)).to eq(true)
      end
    end
  end

  context '#check_diagonal_left' do
    subject(:game) { described_class.new }
    context 'ties to check out of bounds' do
      it 'returns false' do
        expect(game.check_diagonal_left(p1.symbol, 0, 0)).to eq(false)
      end
      it 'returns false' do
        expect(game.check_diagonal_left(p1.symbol, 0, 0)).to eq(false)
      end
    end
    context 'only first and last tokens match' do
      it 'returns false' do
        allow(game).to receive(:layout)
          .and_return([
            [nil, nil, nil, "\u26AA"],
            [nil , nil, nil, nil],
            [nil, nil, nil, nil],
            ["\u26AA", nil, nil, nil]
          ])
        expect(game.check_diagonal_left(p1.symbol, 3, 0)).to eq(false)
      end
    end
    context '4 tokens match diagonally left' do
      it 'returns true' do
        allow(game).to receive(:height).and_return(4)
        allow(game).to receive(:layout)
          .and_return([
            [nil, nil, nil, "\u26AA"],
            [nil, nil, "\u26AA", nil],
            [nil, "\u26AA", nil, nil],
            ["\u26AA", nil, nil, nil]
          ])
        expect(game.check_diagonal_left(p1.symbol, 3, 0)).to eq(true)
      end
    end
  end

  context '#board_to_string' do
    subject(:small_game) { described_class.new(2, 2) }
    it 'returns correct board layout' do
      allow(small_game).to receive(:layout).and_return(
        [
          ["\u2B55", "\u2B55"],
          ["\u2B55", "\u2B55"]
        ]
      )
      expect(small_game.board_to_string).to eq(
        "\u2B55 \u2B55 \n\u2B55 \u2B55 \n"
      )
    end
    it 'returns correct board layout' do
      allow(small_game).to receive(:layout).and_return(
        [
          ["\u2B55", "\u2B55"],
          ["\u26AA", "\u26ab"]
        ]
      )
      expect(small_game.board_to_string).to eq(
        "\u2B55 \u26AA \n\u2B55 \u26ab \n"
      )
    end
  end

  context '#valid_input?' do
    subject(:game) { described_class.new }
    context 'given negative inputs' do
      it 'returns false' do
        input = '-1'
        expect(game.valid_input?(input)).to eq(false)
      end
    end
    context 'given an out of bound intput' do
      it 'returns false' do
        input = '10'
        expect(game.valid_input?(input)).to eq(false)
      end
    end
    context 'if the slot is full' do
      it 'returns false' do
        allow(game).to receive(:layout).and_return([['full']])
        input = '0'
        expect(game.valid_input?(input)).to eq(false)
      end
    end
    context 'given a non integer' do
      it 'returns false' do
        input = 'hi'
        expect(game.valid_input?(input)).to eq(false)
      end
    end
    context 'if the input is within bounds and the top slot is empty' do
      it 'returns true' do
        allow(game).to receive(:layout).and_return(["\u2B55"])
        input = '1'
        expect(game.valid_input?(input)).to eq(true)
      end
    end
  end
end

describe Player do
  context '#set_symbol' do
    subject(:test_player) { described_class.new('p1', 'red') }
    it 'returns unicode U+1F534' do
      expect(test_player.get_symbol('red')).to eq("\u26AA")
    end
    it 'returns unicode U+26AB' do
      expect(test_player.get_symbol('black')).to eq("\u26ab")
    end
    it 'returns nil' do
      expect(test_player.get_symbol('yellow')).to eq(nil)
    end
  end

  context 'returns the correct data' do
    subject(:test_player) { described_class.new( 'Player 1', 'red') }
    it 'returns name as Player 1' do
      expect(test_player.name).to eq('Player 1')
    end
    it 'returns symbol as a red circle unicode' do
      expect(test_player.symbol).to eq("\u26AA")
    end
  end
end
