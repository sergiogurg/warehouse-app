require 'rails_helper'

describe 'Usuário adiciona itens ao pedido' do
  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'João Almeida', email: 'user@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
      description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Dell Technologies LTDA', brand_name: 'Dell', registration_number: '72381189000110', address: 'Avenida da Emancipação, 5000', city: 'Hortolandia', state: 'SP', email: 'contato@dell.com')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    product_a = ProductModel.create!(name: 'Produto A', weight: 15, length: 10, width: 30, height: 20, sku: 'PRODUTO-A-XPTO', supplier: supplier)
    product_b = ProductModel.create!(name: 'Produto B', weight: 15, length: 10, width: 30, height: 20, sku: 'PRODUTO-B-XPTO', supplier: supplier)

    # Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'
    select 'Produto A', from: 'Produto'
    fill_in 'Quantidade', with: '8'
    click_on 'Gravar'

    # Assert
    expect(current_path).to eq(order_path(order.id))
    expect(page).to have_content('Item adicionado com sucesso.')
    expect(page).to have_content('8 x Produto A')
  end

  it 'e não vê produtos de outro fornecedor' do
    # Arrange
    user = User.create!(name: 'João Almeida', email: 'user@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
      description: 'Galpão destinado a cargas internacionais')
    first_supplier = Supplier.create!(corporate_name: 'Dell Technologies LTDA', brand_name: 'Dell', registration_number: '72381189000110', address: 'Avenida da Emancipação, 5000', city: 'Hortolandia', state: 'SP', email: 'contato@dell.com')
    second_supplier = Supplier.create!(corporate_name: 'Fateixa Confeccoes LTDA', brand_name: 'Estilo Feitiço', registration_number: '23743693000108', address: 'Avenida João Pessoa, 5252', city: 'Fortaleza', state: 'CE', email: 'contato@estilofeitico.com')

    order = Order.create!(user: user, warehouse: warehouse, supplier: first_supplier, estimated_delivery_date: 1.day.from_now)

    product_a = ProductModel.create!(name: 'Produto A', weight: 15, length: 10, width: 30, height: 20, sku: 'PRODUTO-A-XPTO', supplier: first_supplier)
    product_b = ProductModel.create!(name: 'Produto B', weight: 15, length: 10, width: 30, height: 20, sku: 'PRODUTO-B-XPTO', supplier: second_supplier)
    
    # Act
    login_as user
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar Item'

    # Assert
    expect(page).to have_content('Produto A')
    expect(page).not_to have_content('Produto B')
  end
end