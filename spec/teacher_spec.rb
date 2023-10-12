# Import du fichier de spécifications
require_relative 'spec_helper'

# Début des spécifications pour la classe Teacher
describe Teacher do
  # Avant chaque test, initialisation d'un enseignant (Teacher)
  before :each do
    @teacher = Teacher.new('Potions', 43, 'Severus Snape', parent_permission: true)
  end

  # Spécification : Vérifie que #new renvoie un objet Teacher
  describe '#new' do
    it 'returns a new teacher object' do
      expect(@teacher).to be_an_instance_of Teacher
    end
  end

  # Spécification : Vérifie que #age renvoie la bonne valeur
  describe 'age' do
    it 'returns the correct age' do
      expect(@teacher.age).to eql 43
    end
  end

  # Spécification : Vérifie que #specialization renvoie la bonne valeur
  describe 'specialization' do
    it 'returns the correct specialization' do
      expect(@teacher.specialization).to eql 'Potions'
    end
  end

  # Spécification : Vérifie que #name renvoie la bonne valeur
  describe 'name' do
    it 'returns the correct name' do
      expect(@teacher.name).to eql 'Severus Snape'
    end
  end
end
