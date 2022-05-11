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

  # it 'com sucesso' do
  # end

  # it 'com dados incompletos' do
  # end
end