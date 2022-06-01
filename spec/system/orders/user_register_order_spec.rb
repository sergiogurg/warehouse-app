require 'rails_helper'

describe 'Usuário cadastra um pedido' do

  it 'e deve estar autenticado' do
    # Arrange

    # Act
    visit root_path
    click_on 'Registrar Pedido'

    # Assert
    expect(current_path).to eq(new_user_session_path)
  end

  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')

    first_warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
      description: 'Galpão destinado a cargas internacionais')
    second_warehouse = Warehouse.create!(name: 'Galpão de Maceió', code: 'MCZ', city: 'Maceió', state: 'AL', area: 50_000,
      address: 'Rua do Jacintinho, 75', postal_code: '75195-712', description: 'Galpão do setor industrial')

    first_supplier = Supplier.create!(corporate_name: 'M Dias Branco S.A. Indústria e Comércio de Alimentos', brand_name: 'Fábrica Fortaleza', registration_number: '07206816000115', address: 'BR 116, km 18', city: 'Eusébio', state: 'CE', email: 'sac@mdiasbranco.com.br')
    second_supplier = Supplier.create!(corporate_name: 'Fateixa Confeccoes LTDA', brand_name: 'Estilo Feitiço', registration_number: '23743693000108', address: 'Avenida João Pessoa, 5252', city: 'Fortaleza', state: 'CE', email: 'contato@estilofeitico.com')

    # Act
    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select second_warehouse.name, from: 'Galpão Destino'
    select second_supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data Prevista', with: '20/12/2022'
    click_on 'Gravar'

    # Assert
      expect(page).to have_content('Pedido registrado com sucesso.')
      expect(page).to have_content('Galpão Destino: Galpão de Maceió')
      expect(page).to have_content('Fornecedor: Fateixa Confeccoes LTDA')
      expect(page).to have_content('Usuário Responsável: Sergio | sergio@email.com')
      expect(page).to have_content('Data Prevista de Entrega: 20/12/2022')
      expect(page).not_to have_content('Aeroporto SP')
      expect(page).not_to have_content('M Dias Branco S.A. Indústria e Comércio de Alimentos')
  end
end