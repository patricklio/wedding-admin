class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "n'est pas une addresse email valide")
    end
  end
end


class User < ApplicationRecord
  ROLES = %w(admin sales client).freeze
  PHONE_NUMBER_REGEX = /((70|76|77|78|30|33))([0-9]{3})([0-9]{2})([0-9]{2})/

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
            format: {
                with: PHONE_NUMBER_REGEX,
                message: "le format du numéro de téléphone est invalide!, Veuillez utilisez celui-ci: (70,76,77,78,30,33)XXXXXXX"
            },
            length: {
                maximum: 9,
                message: "le numéro de téléphone est trop long"
            }
  validates :role,
            presence: {
                message: "Le role est obligatoire"
            }, on: :create


  def name
    "#{ firstname } #{ lastname }"
  end

end


