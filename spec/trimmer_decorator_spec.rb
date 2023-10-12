require_relative 'spec_helper'
describe TrimmerDecorator do
  before :each do
    @nameable = double('Nameable', correct_name: 'Albus Dumbledore')
    @decorator = TrimmerDecorator.new(@nameable)
  end
  describe '#new' do
    it 'returns a new TrimmerDecorator object' do
      expect(@decorator).to be_an_instance_of TrimmerDecorator
    end
  end
  describe 'correct_name' do
    it 'returns a trimmed name' do
      expect(@decorator.correct_name).to eql 'Albus Dumb'
    end
  end
end