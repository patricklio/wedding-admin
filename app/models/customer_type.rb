class CustomerType < ApplicationRecord
  has_many :customers
  scope :business, -> { where(name: 'business') }
end
