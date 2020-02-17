class UserAccount < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :user

  validates :password,
            presence: {
                message: "Le mot de passe est obligatoire"
            },
            length: {
                minimum: 8,
                message: "le mot de passe est trop court"
            },
            confirmation: true
end
