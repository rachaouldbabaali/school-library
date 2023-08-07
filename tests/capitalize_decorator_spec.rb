require_relative '../decorators/capitalize_decorator' # Adjust the require path

describe CapitalizeDecorator do
  let(:nameable) { double('Nameable') }
  subject(:decorator) { described_class.new(nameable) }

  describe '#correct_name' do
    it 'capitalizes the name from the nameable object' do
      allow(nameable).to receive(:correct_name).and_return('john')
      trans = decorator.correct_name
      expect(trans).to eq('John')
    end
  end

  describe '#to_capitalize' do
    it 'capitalizes a given name' do
      name = decorator.to_capitalize('john')
      expect(name).to eq('John')
    end
  end
end
