#frozen_string_literal: true

require_relative '../lib/chess'

describe Pawn do
  context 'has correct variables' do
    subject(:new_pawn) { described_class.new('white') }
    it 'returns \u2659' do
      expect(new_pawn.symbol).to eq("\u2659")
    end
    it 'returns white' do
      expect(new_pawn.color).to eq('white')
    end
    it 'returns [[1, 0], [2, 0]]' do
      expect(new_pawn.allowed_moves).to eq([[1, 0], [2, 0]])
    end
    it 'returns [[1, 1], [1, -1]]' do
      expect(new_pawn.allowed_attacks).to eq([[1, 1], [1, -1]])
    end
  end
end
