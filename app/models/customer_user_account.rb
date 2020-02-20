class CustomerUserAccount < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  belongs_to :customer

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
      message: ->(object, data) do
        "L'adresse email  #{data[:value]} existe déja!"
      end
  }
end
