require 'rails_helper'

describe 'Usuário cadastra um modelo de produto' do
  it 'a partir do menu inicial' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo Modelo de Produto'

    # Assert
    expect(page).to have_content('Novo Modelo de Produto')
    expect(page).to have_field('Nome')
    expect(page).to have_field('Peso')
    expect(page).to have_field('Comprimento')
    expect(page).to have_field('Altura')
    expect(page).to have_field('Largura')
    expect(page).to have_field('SKU')
    expect(page).to have_select('Fornecedor')
  end

  it 'com sucesso' do
    # Arrange
    Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', registration_number: '12345678912345', address: 'Avenida das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    Supplier.create!(corporate_name: 'Lg Electronics do Brasil LTDA', brand_name: 'LG', registration_number: '01166372000155', address: 'Avenida Dom Pedro I, 7777', city: 'Taubaté', state: 'SP', email: 'contato@lg.com.br')

    # Act
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo Modelo de Produto'
    fill_in 'Nome', with: 'TV 40 Polegadas'
    fill_in 'Peso', with: 10_000
    fill_in 'Comprimento', with: 90
    fill_in 'Altura', with: 60
    fill_in 'Largura', with: 10
    fill_in 'SKU', with: 'TV40-SAMSU-XPTO'
    select 'Samsung', from: 'Fornecedor'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Modelo de produto cadastrado com sucesso')
    expect(page).to have_content('TV 40 Polegadas')
    expect(page).to have_content('Fornecedor: Samsung')
    expect(page).to have_content('SKU: TV40-SAMSU-XPTO')
    expect(page).to have_content('Dimensão: 90cm x 60cm x 10cm')
    expect(page).to have_content('Peso: 10000 g')
  end

  it 'e deve preencher todos os campos' do
    # Arrange
    Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', registration_number: '12345678912345', address: 'Avenida das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

    # Act
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Cadastrar Novo Modelo de Produto'
    fill_in 'Nome', with: ''
    fill_in 'SKU', with: ''
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Não foi possível cadastrar o modelo de produto')
  end
end
