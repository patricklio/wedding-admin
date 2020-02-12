class Partner < ApplicationRecord
  geocoded_by :address
  before_save :geocode, if: ->(partner){ partner.address.present? }
end
