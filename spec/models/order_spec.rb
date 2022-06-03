require 'rails_helper'

RSpec.describe Order, type: :model do

  describe '#valid?' do
    it 'deve ter um código' do
      # Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
      warehouse = Warehouse.create!(name: 'Santos Dumont', code: 'SDU', city: 'Rio de Janeiro', state: 'RJ', area: 60_000,
        address: 'Avenida do Porto, 1000', postal_code: '20015-510' , description: 'Galpão do Rio')
      supplier = Supplier.create!(corporate_name: 'Beats Bebidas Mistas LTDA', brand_name: 'Beats', registration_number: '15427207000203', address: 'Avenida das Pocs, 616', city: 'São Paulo', state: 'SP', email: 'sac-loja@beatsoficial.com.br')

      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-01')

      # Act
      result = order.valid?

      # Assert
      expect(result).to be(true)

    end
  end

  describe 'gera um código aleatório' do
    it 'ao criar um novo pedido' do
      # Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
      warehouse = Warehouse.create!(name: 'Santos Dumont', code: 'SDU', city: 'Rio de Janeiro', state: 'RJ', area: 60_000,
        address: 'Avenida do Porto, 1000', postal_code: '20015-510' , description: 'Galpão do Rio')
      supplier = Supplier.create!(corporate_name: 'Beats Bebidas Mistas LTDA', brand_name: 'Beats', registration_number: '15427207000203', address: 'Avenida das Pocs, 616', city: 'São Paulo', state: 'SP', email: 'sac-loja@beatsoficial.com.br')

      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-01')

      # Act
      order.save!
      result = order.code
      # Assert
      expect(result).not_to be_empty
      expect(result.length).to eq(8)
    end

    it 'e o código é único' do
      # Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
      warehouse = Warehouse.create!(name: 'Santos Dumont', code: 'SDU', city: 'Rio de Janeiro', state: 'RJ', area: 60_000,
        address: 'Avenida do Porto, 1000', postal_code: '20015-510' , description: 'Galpão do Rio')
      supplier = Supplier.create!(corporate_name: 'Beats Bebidas Mistas LTDA', brand_name: 'Beats', registration_number: '15427207000203', address: 'Avenida das Pocs, 616', city: 'São Paulo', state: 'SP', email: 'sac-loja@beatsoficial.com.br')

      first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-01')

      second_order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-11-15')
      # Act
      second_order.save!
      # Assert
      expect(second_order.code).not_to eq(first_order.code)
    end
  end
end
