class Part < ApplicationRecord
  validates :part_desc, presence: true, uniqueness: { case_sensitive: false }, length: {minimum: 1}
end
