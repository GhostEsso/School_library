require_relative 'spec_helper'

describe Student do
  before(:each) do
    @student = Student.new(18, 'John Doe', true)
  end

  describe '#new' do
    it 'returns a new student object' do
      expect(@student).to be_an_instance_of Student
    end

    it 'has the correct name' do
      expect(@student.name).to eql 'John Doe'
    end

    it 'has the correct age' do
      expect(@student.age).to eql 18
    end

    it 'has the correct parent permission' do
      expect(@student.parent_permission).to be_truthy
    end

    it 'has nil classroom by default' do
      expect(@student.classroom).to be_nil
    end
  end

  describe 'classroom' do
    it 'returns the correct classroom' do
      expect(@student.classroom).to eql nil
    end
  end
  
  describe '#play_hooky' do
    it 'returns a shrug emoticon' do
      expect(@student.play_hooky).to eql '¯\(ツ)/¯'
    end
  end
end
