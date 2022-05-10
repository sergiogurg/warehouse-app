require 'rails_helper'

describe 'Usuário edita um galpão' do
  it 'a partir da página de detalhes' do
    # Arrange
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
                                  state: 'SP', area: 100_000, address: 'Avenida do Aeroporto, 1000',
                                  postal_code: '15000-000', description: 'Galpão destinado a cargas internacionais')    
    # Act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'

    # Assert
    expect(page).to have_content('Editar Galpão')

    expect(page).to have_field('Nome', with: 'Aeroporto SP')
    expect(page).to have_field('Descrição', with: 'Galpão destinado a cargas internacionais')
    expect(page).to have_field('Código', with: 'GRU')
    expect(page).to have_field('Endereço', with: 'Avenida do Aeroporto, 1000')
    expect(page).to have_field('Cidade', with: 'Guarulhos')
    expect(page).to have_field('Estado', with: 'SP')
    expect(page).to have_field('CEP', with: '15000-000')
    expect(page).to have_field('Área', with: 100_000)
  end

  it 'com sucesso' do
  # Arrange
  warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
    state: 'SP', area: 100_000, address: 'Avenida do Aeroporto, 1000',
    postal_code: '15000-000', description: 'Galpão destinado a cargas internacionais')   

  # Act
  visit root_path
  click_on 'Aeroporto SP'
  click_on 'Editar'
  fill_in 'Nome', with: 'Galpão Internacional'
  fill_in 'Código', with: 'GPI'
  fill_in 'Endereço', with: 'Avenida dos Galpões, 150'
  fill_in 'CEP', with: '25091-427'
  fill_in 'Área', with: 54_000
  click_on 'Enviar'

  # Assert
  expect(page).to have_content('Galpão atualizado com sucesso')
  expect(page).to have_content("Galpão GPI")
  expect(page).to have_content('Galpão destinado a cargas internacionais')
  expect(page).to have_content('Nome: Galpão Internacional')
  expect(page).to have_content('Área: 54000 m²')
  expect(page).to have_content('Endereço: Avenida dos Galpões, 150 CEP: 25091-427')
  end

  it 'e mantém os campos obrigatórios' do
    # Arrange
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
      state: 'SP', area: 100_000, address: 'Avenida do Aeroporto, 1000',
      postal_code: '15000-000', description: 'Galpão destinado a cargas internacionais')

    # Act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'CEP', with: ''
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Não foi possível atualizar o galpão')
    
  end

end