class Repairoption < ApplicationRecord
  belongs_to :repairoption_category

  def optional?
    optional
  end
end
