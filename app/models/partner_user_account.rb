class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "n'est pas une addresse email valide")
    end
  end
end

class PartnerUserAccount < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :partner
  ROLES = %w(admin mechanic).freeze

  #Partner user account  validation

  validates :password,
            presence: {
              message: 'Le mot de passe est obligatoire', on: :update
            },
            length: {
              minimum: 8,
              message: 'le mot de passe est trop court', on: :update
            },
            confirmation: true

  validates :email,
            presence: {
                message: "L'email est obligatoire"
            },
            uniqueness: {
                case_sensitive: false,
                scope: :partner,
                message: ->(object, data) do
                  "Cette adresse email  #{data[:value]} existe déja pour un compte!"
                end
            },
            email:true
  validates :role,
            presence: {
                message: "Le role est obligatoire"
            }, on: :create


end
