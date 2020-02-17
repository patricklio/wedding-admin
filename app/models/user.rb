class User < ApplicationRecord
    ROLES = %w(admin sale).freeze

    has_one :user_account, dependent: :destroy

    validates :email, presence: true, uniqueness: true

end
