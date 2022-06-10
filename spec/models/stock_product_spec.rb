require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'gera um número de série' do
    it 'ao criar um StockProduct' do
      # Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
      warehouse = Warehouse.create!(name: 'Santos Dumont', code: 'SDU', city: 'Rio de Janeiro', state: 'RJ', area: 60_000,
        address: 'Avenida do Porto, 1000', postal_code: '20015-510' , description: 'Galpão do Rio')
      supplier = Supplier.create!(corporate_name: 'Beats Bebidas Mistas LTDA', brand_name: 'Beats', registration_number: '15427207000203', address: 'Avenida das Pocs, 616', city: 'São Paulo', state: 'SP', email: 'sac-loja@beatsoficial.com.br')
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now, status: 'delivered')
      product = ProductModel.create!(supplier: supplier, name: 'Cadeira Gamer', weight: 5, length: 70, height: 100, width: 75, sku: 'CAD-GAMER-1234')

      # Act
      stock_product = StockProduct.create!(order: order, product_model: product, warehouse: warehouse)

      # Assert
      expect(stock_product.serial_number.length).to eq(20)
    end

    it 'e não deve ser modificado' do
      # Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
      first_warehouse = Warehouse.create!(name: 'Santos Dumont', code: 'SDU', city: 'Rio de Janeiro', state: 'RJ', area: 60_000,
        address: 'Avenida do Porto, 1000', postal_code: '20015-510' , description: 'Galpão do Rio')
      second_warehouse = Warehouse.create!(name: 'Maceió', code: 'MCZ', city: 'Maceió', state: 'AL', area: 50_000,
                address: 'Rua do Jacintinho, 75', postal_code: '75195-712', description: 'Galpão do setor industrial')
      supplier = Supplier.create!(corporate_name: 'Beats Bebidas Mistas LTDA', brand_name: 'Beats', registration_number: '15427207000203', address: 'Avenida das Pocs, 616', city: 'São Paulo', state: 'SP', email: 'sac-loja@beatsoficial.com.br')
      order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now, status: 'delivered')
      product = ProductModel.create!(supplier: supplier, name: 'Cadeira Gamer', weight: 5, length: 70, height: 100, width: 75, sku: 'CAD-GAMER-1234')
      stock_product = StockProduct.create!(order: order, product_model: product, warehouse: first_warehouse)
      original_serial_number = stock_product.serial_number

      # Act
      stock_product.update(warehouse: second_warehouse)

      # Assert
      expect(stock_product.serial_number).to eq(original_serial_number)
    end
  end
end
