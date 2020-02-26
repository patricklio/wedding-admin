class User < ApplicationRecord
  ROLES = %w(admin sales client).freeze

  has_one :user_account, dependent: :destroy

  #User validation
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
                  "L'adresse email  #{data[:value]} existe déja!"
                end
            },
            email:true
  validates :phone_number,
            presence: {
                message: "Le numéro de téléphone est obligatoire"
            },
            uniqueness: {
                message: ->(object, data) do
                  "Le numéro   #{data[:value]} existe déja!"
                end, on: :create
            },
            length: {
                maximum: 9,
                message: "le numéro de téléphone est trop long"
            },
            phone: true
  validates :role,
            presence: {
                message: "Le role est obligatoire"
            }, on: :create


  def name
    "#{ firstname } #{ lastname }"
  end

  def admin?
    role == 'admin'
  end

end


