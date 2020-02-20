class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "Cette addresse n'est pas valide")
    end
  end
end

class Partner < ApplicationRecord
  has_many :partner_user_accounts, dependent: :destroy
  PHONE_NUMBER_REGEX = /((70|76|77|78|30|33))([0-9]{3})([0-9]{2})([0-9]{2})/
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
            format: {
              with: PHONE_NUMBER_REGEX,
              message: "le format du numéro de téléphone est invalide!, Veuillez utilisez celui-ci: (70,76,77,78,30,33)XXXXXXX"
            },
            length: {
                maximum: 9,
                message: "le numéro de téléphone est trop long"
            }


  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
  
  ROLES = %w(admin mechanic).freeze
end
