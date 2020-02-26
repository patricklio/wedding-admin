class Customer < ApplicationRecord
  has_many :vehicles
  has_many  :customer_user_accounts, dependent: :destroy
  belongs_to :customer_type, foreign_key: :customer_type_id

  validates :address, presence: { message: 'Veuillez fournir une adresse' }
  validates :company_name, presence: { message: "Le nom de l'entreprise est obligatoire" }
  validates :customer_type_id, presence: { message: "Le choix d'un type de client est obligatoire" }
  validates :firstname,
            presence: {
                message: "Le prénom  est obligatoire"
            },
            length: {
                minimum: 2,
                message: "le prenom est trop court"
            }
  validates :lastname,
            presence: {
                message: "Le nom  est obligatoire"
            },
            length: {
                minimum: 2,
                message: "le nom est trop court"
            }
  validates :email,
            presence: {
                message: "L'email est obligatoire"
            },
            uniqueness: {
                case_sensitive: false,
                message: ->(object, data) do
                  "L'adresse email #{data[:value]} existe déja!"
                end
            },
            email: true
  validates :phone_number,
            presence: {
                message: "Le numéro de téléphone"
            },
            uniqueness: {
                message: ->(object, data) do
                  "Le numéro #{data[:value]} existe déja!"
                end
            },
            length: {
                maximum: 9,
                message: "le numéro de téléphone est trop long"
            },
            phone: true

  def name
    "#{ firstname } #{ lastname}"
  end
end
