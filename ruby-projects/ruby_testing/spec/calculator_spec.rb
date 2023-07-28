#spec/caluclator_spec.rb

require './lib/calculator'
describe Calculator do
  describe '#add' do
    it "returns the sum of two numbers" do
      calculator = Calculator.new
      expect(calculator.add(5, 2)).to eql(7)
    end
    it 'returns the sum of more than two numbers' do
      calculator = Calculator.new
      expect(calculator.add(2, 5, 7)).to eql(14)
    end
  end

  describe '#multiply' do
    it 'returns the multiple of two numbers' do
      calculator = Calculator.new
      expect(calculator.multiply(2, 5)).to eql(10)
    end
    it 'returns the multiple of more than two numbers' do
      calculator = Calculator.new
      expect(calculator.multiply(2, 5, 7)).to eql(70)
    end
  end

  describe '#subtract' do
    it "returns the difference of two numbers" do
      calculator = Calculator.new
      expect(calculator.subtract(5, 2)).to eql(3)
    end
  end

  describe '#divide' do
    it "returns the division of the first number by the second" do
      calculator = Calculator.new
      expect(calculator.divide(10, 2)).to eql(5)
    end
  end
end
