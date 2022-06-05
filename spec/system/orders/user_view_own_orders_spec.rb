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

    first_order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    second_order = Order.create!(user: carla, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 5.day.from_now)
    third_order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 10.day.from_now)

    # Act
    login_as(joao)
    visit root_path
    click_on 'Meus Pedidos'
    # Assert
    expect(page).to have_content(first_order.code)
    expect(page).not_to have_content(second_order.code)
    expect(page).to have_content(third_order.code)
  end
end