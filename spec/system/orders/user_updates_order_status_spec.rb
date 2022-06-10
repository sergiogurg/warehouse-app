require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
  it 'e ele foi entregue' do
    # Arrange
    joao = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
      description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'M Dias Branco S.A. Indústria e Comércio de Alimentos', brand_name: 'Fábrica Fortaleza', registration_number: '07206816000115', address: 'BR 116, km 18', city: 'Eusébio', state: 'CE', email: 'sac@mdiasbranco.com.br')
    product = ProductModel.create!(supplier: supplier, name: 'Cadeira Gamer', weight: 5, length: 70, height: 100, width: 75, sku: 'CAD-GAMER-1234')
    order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: :pending)
    OrderItem.create!(order: order, product_model: product, quantity: 5)

    # Act
    login_as(joao)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como ENTREGUE'

    # Assert
    expect(current_path).to eq(order_path(order.id))
    expect(page).to have_content('Situação do Pedido: Entregue')
    expect(page).not_to have_button('Marcar como ENTREGUE')
    expect(page).not_to have_button('Marcar como CANCELADO')
    expect(StockProduct.count).to eq(5)
    estoque = StockProduct.where(product_model: product, warehouse: warehouse).count
    expect(estoque).to eq(5)
  end

  it 'e ele foi cancelado' do
    # Arrange
    joao = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
      description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'M Dias Branco S.A. Indústria e Comércio de Alimentos', brand_name: 'Fábrica Fortaleza', registration_number: '07206816000115', address: 'BR 116, km 18', city: 'Eusébio', state: 'CE', email: 'sac@mdiasbranco.com.br')
    order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: :pending)
    product = ProductModel.create!(supplier: supplier, name: 'Cadeira Gamer', weight: 5, length: 70, height: 100, width: 75, sku: 'CAD-GAMER-1234')
    OrderItem.create!(order: order, product_model: product, quantity: 5)

    # Act
    login_as(joao)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Marcar como CANCELADO'

    # Assert
    expect(current_path).to eq(order_path(order.id))
    expect(page).to have_content('Situação do Pedido: Cancelado')
    expect(page).not_to have_button('Marcar como ENTREGUE')
    expect(page).not_to have_button('Marcar como CANCELADO')
    expect(StockProduct.count).to eq(0)
  end

end