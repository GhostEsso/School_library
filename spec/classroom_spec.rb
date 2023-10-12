# On inclut le fichier spec_helper
require_relative 'spec_helper'

# On commence la description des tests pour la classe Classroom
describe Classroom do
  # Avant chaque test, on crée une nouvelle instance de Classroom
  before :each do
    @classroom = Classroom.new('Potions Classroom')
  end

  # On décrit le comportement de la méthode 'new'
  describe '#new' do
    it 'returns a new classroom object' do
      expect(@classroom).to be_an_instance_of Classroom
    end
  end

  # On décrit le comportement de la méthode 'label'
  describe 'label' do
    it 'returns the correct label' do
      expect(@classroom.label).to eql 'Potions Classroom'
    end
  end
end
