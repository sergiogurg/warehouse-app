class ProductModel < ApplicationRecord
  belongs_to :supplier
  validates :name, :weight, :length, :height, :width, :sku, :supplier, presence: true
end
