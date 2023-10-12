require_relative 'spec_helper'

describe Person do
  before :each do
    @person = Person.new(22, 'Maximilianus')
  end

  describe '#new' do
    it 'returns a new Person object' do
      expect(@person).to be_an_instance_of Person
    end

    it 'has correct attributes' do
      expect(@person.name).to eql 'Maximilianus'
      expect(@person.age).to eql 22
    end
  end

  describe '#to_hash' do
    it 'returns a hash with person details' do
      hash = @person.to_hash
      expect(hash['type']).to eql 'Person'
      expect(hash['age']).to eql 22
      expect(hash['name']).to eql 'Maximilianus'
    end
  end

  describe '#can_use_services?' do
    it 'returns true for an adult' do
      adult = Person.new(30, 'Adult')
      expect(adult.can_use_services?).to be true
    end

    it 'returns true with parent permission for a minor' do
      minor = Person.new(17, 'Minor', parent_permission: true)
      expect(minor.can_use_services?).to be true
    end

    it 'returns false for a minor without parent permission' do
      minor = Person.new(17, 'Minor', parent_permission: false)
      expect(minor.can_use_services?).to be false
    end
  end
end
