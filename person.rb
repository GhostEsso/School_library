class Person
    # Utilisation de attr_accessor pour créer les méthodes de lecture et d'écriture pour :name et :age.
    attr_accessor :name, :age
  
    # Utilisation de attr_reader pour créer la méthode de lecture pour :id.
    attr_reader :id
  
    # Le constructeur de la classe Person avec des paramètres par défaut.
    def initialize(name = "Unknown", age = 0, parent_permission = true)
      # Génération d'un identifiant aléatoire.
      @id = generate_id
  
      # Assignation des valeurs passées en paramètre aux variables d'instance.
      @name = name
      @age = age
      @parent_permission = parent_permission
    end
  
    # Méthode pour déterminer si la personne peut utiliser les services (basée sur l'âge et la permission parentale).
    def can_use_services?
      of_age? || @parent_permission
    end
  
    private
  
    # Méthode pour vérifier si la personne est majeure.
    def of_age?
      @age >= 18
    end
  
    # Méthode pour générer un identifiant aléatoire.
    def generate_id
      rand(1..1000)
    end
  end
  