class Order < ApplicationRecord
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user

  validates :code, :estimated_delivery_date, presence: true
  validate :estimated_delivery_date_cannot_be_in_the_future

  before_validation :generate_code

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def estimated_delivery_date_cannot_be_in_the_future
    if self.estimated_delivery_date.present? && self.estimated_delivery_date <= Date.current
      self.errors.add(:estimated_delivery_date, ' deve ser futura.')
    end
  end
end
