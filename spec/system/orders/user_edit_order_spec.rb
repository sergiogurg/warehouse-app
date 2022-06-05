require 'rails_helper'

describe 'Usuário edita pedido' do
  it 'e deve estar autenticado' do
    # Arrange
    joao = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
      description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'M Dias Branco S.A. Indústria e Comércio de Alimentos', brand_name: 'Fábrica Fortaleza', registration_number: '07206816000115', address: 'BR 116, km 18', city: 'Eusébio', state: 'CE', email: 'sac@mdiasbranco.com.br')
    order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    # Act
    visit edit_order_path(order.id)

    # Assert
    expect(current_path).to eq(new_user_session_path)
  end

  it 'com sucesso' do
    # Arrange
    joao = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
      description: 'Galpão destinado a cargas internacionais')
    first_supplier = Supplier.create!(corporate_name: 'M Dias Branco S.A. Indústria e Comércio de Alimentos', brand_name: 'Fábrica Fortaleza', registration_number: '07206816000115', address: 'BR 116, km 18', city: 'Eusébio', state: 'CE', email: 'sac@mdiasbranco.com.br')
    second_supplier = Supplier.create!(corporate_name: 'Fateixa Confeccoes LTDA', brand_name: 'Estilo Feitiço', registration_number: '23743693000108', address: 'Avenida João Pessoa, 5252', city: 'Fortaleza', state: 'CE', email: 'contato@estilofeitico.com')
    order = Order.create!(user: joao, warehouse: warehouse, supplier: first_supplier, estimated_delivery_date: 1.day.from_now)

    # Act
    login_as(joao)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Editar'
    fill_in 'Data Prevista de Entrega', with: 5.days.from_now.to_date
    select 'Fateixa Confeccoes LTDA', from: 'Fornecedor'
    click_on 'Gravar'

    # Assert
    expect(page).to have_content('Pedido atualizado com sucesso.')
    expect(page).to have_content('Fornecedor: Fateixa Confeccoes LTDA')
    expect(page).to have_content("Data Prevista de Entrega: #{I18n.localize(5.days.from_now.to_date)}")
  end

  it 'somente se o pedido pertencer àquele usuário' do
    # Arrange
    andre = User.create!(name: 'André', email: 'andre@email.com', password: 'password')
    joao = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
      description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'M Dias Branco S.A. Indústria e Comércio de Alimentos', brand_name: 'Fábrica Fortaleza', registration_number: '07206816000115', address: 'BR 116, km 18', city: 'Eusébio', state: 'CE', email: 'sac@mdiasbranco.com.br')
    order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    # Act
    login_as(andre)
    visit edit_order_path(order.id)

    # Assert
    expect(current_path).to eq(root_path)
  end

end