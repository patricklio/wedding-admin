class Partner < ApplicationRecord
  has_many :partner_user_accounts, dependent: :destroy
  validates :name,
            presence: {
                message: "Le nom du partenaire est obligatoire"
            },
            length: {
                minimum: 2,
                message: "le nom du partenaire est trop court"
            }
  validates :address,
            presence: {
                message: "L'addresse du partenaire  est obligatoire"
            },
            length: {
                minimum: 2,
                message: "L'addresse du partenaire est trop courte"
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
            email: true
  validates :phone_number,
            presence: {
                message: "Le numero de téléphone est obligatoire"
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


  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  ROLES = %w(admin mechanic).freeze
end
