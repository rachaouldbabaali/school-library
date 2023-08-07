require_relative '../decorators/decorator'

describe BaseDecorator do
  let(:nameable) { double('Nameable') }
  subject(:decorator) { described_class.new(nameable) }

  describe '#initialize' do
    it 'assigns the nameable object' do
      expect(decorator.instance_variable_get(:@nameable)).to eq(nameable)
    end
  end

  describe '#correct_name' do
    it 'delegates to the nameable object' do
      expect(nameable).to receive(:correct_name).and_return('John Doe')
      expect(decorator.correct_name).to eq('John Doe')
    end
  end
end
