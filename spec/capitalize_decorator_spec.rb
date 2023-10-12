require_relative 'spec_helper'

class DummyClass
  attr_accessor :correct_name
end

describe CapitalizeDecorator do
  let(:dummy_class) { DummyClass.new }
  let(:decorator) { CapitalizeDecorator.new(dummy_class) }

  describe '#correct_name' do
    it 'capitalizes the correct_name of the decorated object' do
      dummy_class.correct_name = 'john doe'
      expect(decorator.correct_name).to eq('John doe')

      dummy_class.correct_name = 'emma smith'
      expect(decorator.correct_name).to eq('Emma smith')
    end
  end
end
