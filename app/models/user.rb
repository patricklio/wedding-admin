class User < ApplicationRecord

  #User validation
  validates :firstname, presence: true, length: { minimum: 2 }
  validates :lastname, presence: true, length: { minimum: 2 }
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true, length: { minimum: 9 }


  def name
    " #{ firstname } #{ lastname } "
  end
end
