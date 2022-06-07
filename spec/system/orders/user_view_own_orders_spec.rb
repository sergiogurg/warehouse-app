require 'rails_helper'

describe 'Usuário vê os seus pedidos' do
  it 'e deve estar autenticado' do
    # Arrange

    # Act
    visit root_path
    click_on 'Meus Pedidos'
    # Assert
    expect(current_path).to eq(new_user_session_path)
  end

  it 'e não vê outros pedidos' do
    # Arrange
    joao = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    carla = user = User.create!(name: 'Carla', email: 'carla@email.com', password: 'password')
    
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
      description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'M Dias Branco S.A. Indústria e Comércio de Alimentos', brand_name: 'Fábrica Fortaleza', registration_number: '07206816000115', address: 'BR 116, km 18', city: 'Eusébio', state: 'CE', email: 'sac@mdiasbranco.com.br')

    first_order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: 'pending')
    second_order = Order.create!(user: carla, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 5.day.from_now, status: 'delivered')
    third_order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 10.day.from_now, status: 'canceled')

    # Act
    login_as(joao)
    visit root_path
    click_on 'Meus Pedidos'
    # Assert
    expect(page).to have_content(first_order.code)
    expect(page).to have_content('Pendente')
    expect(page).not_to have_content(second_order.code)
    expect(page).not_to have_content('Entregue')
    expect(page).to have_content(third_order.code)
    expect(page).to have_content('Cancelado')
  end

  it 'e visita um pedido' do
    # Arrange
    joao = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
      description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'M Dias Branco S.A. Indústria e Comércio de Alimentos', brand_name: 'Fábrica Fortaleza', registration_number: '07206816000115', address: 'BR 116, km 18', city: 'Eusébio', state: 'CE', email: 'sac@mdiasbranco.com.br')
    order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    # Act
    login_as(joao)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code

    # Assert
    expect(page).to have_content('Detalhes do Pedido')
    expect(page).to have_content(order.code)
    expect(page).to have_content('Galpão Destino: GRU => Aeroporto SP')
    expect(page).to have_content('Fornecedor: M Dias Branco S.A. Indústria e Comércio de Alimentos')
    formatted_date = I18n.localize(1.day.from_now.to_date)
    expect(page).to have_content("Data Prevista de Entrega: #{formatted_date}")
  end

  it 'mas não visita pedidos dos outros usuários' do
    andre = User.create!(name: 'André', email: 'andre@email.com', password: 'password')
    joao = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
      description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'M Dias Branco S.A. Indústria e Comércio de Alimentos', brand_name: 'Fábrica Fortaleza', registration_number: '07206816000115', address: 'BR 116, km 18', city: 'Eusébio', state: 'CE', email: 'sac@mdiasbranco.com.br')
    order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    # Act
    login_as(andre)
    visit order_path(order.id)

    # Assert
    expect(current_path).not_to eq(order_path(order.id))
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Você não possui acesso a este pedido.')
  end

  it 'e vê itens do pedido' do
    # Arrange
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
      description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', registration_number: '12345678912345', address: 'Avenida das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    product_a = ProductModel.create!(name: 'Produto A', weight: 15, length: 10, width: 30, height: 20, sku: 'PRODUTO-A-XPTO', supplier: supplier)
    product_b = ProductModel.create!(name: 'Produto B', weight: 15, length: 10, width: 30, height: 20, sku: 'PRODUTO-B-XPTO', supplier: supplier)
    product_c = ProductModel.create!(name: 'Produto C', weight: 15, length: 10, width: 30, height: 20, sku: 'PRODUTO-C-XPTO', supplier: supplier)

    OrderItem.create!(product_model: product_a, order: order, quantity: 19)
    OrderItem.create!(product_model: product_b, order: order, quantity: 12)

    # Act
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code

    # Assert
    expect(page).to have_content('Itens do Pedido')
    expect(page).to have_content('19 x Produto A')
    expect(page).to have_content('12 x Produto B')
  end

end