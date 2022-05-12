class Warehouse < ApplicationRecord
  validates :name, :code, :city, :area, :address, :postal_code, :description, :state, presence: true
  validates :name, :code, uniqueness: true
  validates :postal_code, format: { with: /\A[0-9]{5}[-][0-9]{3}\z/ }
end
