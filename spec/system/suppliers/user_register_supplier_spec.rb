require 'rails_helper'

describe 'Usuário cadastra fornecedor' do
  it 'a partir do menu' do
    # Arrange

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'

    # Assert
    expect(page).to have_field('Razão Social')
    expect(page).to have_field('Nome Fantasia')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Email')
    expect(page).to have_button('Criar Fornecedor')
  end

  it 'com sucesso' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'
    fill_in 'Razão Social', with: 'Beats Bebidas Mistas LTDA'
    fill_in 'Nome Fantasia', with: 'Beats'
    fill_in 'CNPJ', with: '612596515755'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'Endereço', with: 'Avenida das Pocs, 616'
    fill_in 'Email', with: 'sac-loja@beatsoficial.com.br'
    click_on 'Criar Fornecedor'

    # Assert
    expect(current_path).to eq(suppliers_path)
    expect(page).to have_content('Fornecedor cadastrado com sucesso.')
    expect(page).to have_content('Beats')
    expect(page).to have_content('São Paulo - SP')
  end

  # it 'com dados incompletos' do
  # end
end