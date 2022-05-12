require 'rails_helper'

describe 'Usuário cadastra um galpão' do
  it 'a partir da tela inicial' do
    # Arrange

    # Act
    visit root_path
    click_on 'Cadastrar Galpão'

    # Assert
    expect(page).to have_field('Nome')
    expect(page).to have_field('Descrição')
    expect(page).to have_field('Código')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_field('CEP')
    expect(page).to have_field('Área')
  end

  it 'com sucesso' do
    # Arrange

    # Act
    visit root_path
    click_on 'Cadastrar Galpão'
    fill_in 'Nome', with: 'Rio de Janeiro'
    fill_in 'Descrição', with: 'Galpão da zona portuária do Rio'
    fill_in 'Código', with: 'RIO'
    fill_in 'Endereço', with: 'Avenida do Museu do Amanhã, 1000'
    fill_in 'Cidade', with: 'Rio de Janeiro'
    fill_in 'Estado', with: 'RJ'
    fill_in 'CEP', with: '20100-000'
    fill_in 'Área', with: 32_000
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Galpão cadastrado com sucesso.')
    expect(page).to have_content('Rio de Janeiro')
    expect(page).to have_content('Código')
    expect(page).to have_content('Cidade')
    expect(page).to have_content('Estado')
    expect(page).to have_content('Área')

  end

  it 'com dados incompletos' do
    # Arrange

    # Act
    visit root_path
    click_on 'Cadastrar Galpão'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Cidade', with: ''
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Galpão não cadastrado.')

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Código não pode ficar em branco')
    expect(page).to have_content('Cidade não pode ficar em branco')
    expect(page).to have_content('Área não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
    expect(page).to have_content('CEP não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Estado não pode ficar em branco')
  end

  it 'com um CEP de formato inválido' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Cadastrar Galpão'
    fill_in 'CEP', with: '123'
    click_on 'Enviar'
    # Assert
    expect(page).to have_content('CEP não é válido')
  end

end