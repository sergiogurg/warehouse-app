require 'rails_helper'

describe 'Usuário edita um fornecedor' do
  it 'a partir da página de detalhes' do
    # Arrange
    supplier = Supplier.create!(corporate_name: 'Fateixa Confeccoes LTDA', brand_name: 'Estilo Feitiço', registration_number: '23743693000108', address: 'Avenida João Pessoa, 5252', city: 'Fortaleza', state: 'CE', email: 'contato@estilofeitico.com')

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Estilo Feitiço'
    click_on 'Editar'

    # Assert
    expect(page).to have_content('Editar Fornecedor')

    expect(page).to have_field('Razão Social', with: 'Fateixa Confeccoes LTDA')
    expect(page).to have_field('Nome Fantasia', with: 'Estilo Feitiço')
    expect(page).to have_field('CNPJ', with: '23743693000108')
    expect(page).to have_field('Endereço', with: 'Avenida João Pessoa, 5252')
    expect(page).to have_field('Cidade', with: 'Fortaleza')
    expect(page).to have_field('Estado', with: 'CE')
    expect(page).to have_field('Email', with: 'contato@estilofeitico.com')
  end

  it 'e cancela a edição' do
    # Arrange
    supplier = Supplier.create!(corporate_name: 'Fateixa Confeccoes LTDA', brand_name: 'Estilo Feitiço', registration_number: '23743693000108', address: 'Avenida João Pessoa, 5252', city: 'Fortaleza', state: 'CE', email: 'contato@estilofeitico.com')
    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Estilo Feitiço'
    click_on 'Editar'
    click_on 'Cancelar'

    # Assert
    expect(current_path).to eq(supplier_path(supplier.id))
  end

  it 'com sucesso' do
    # Arrange
    supplier = Supplier.create!(corporate_name: 'Fateixa Confeccoes LTDA', brand_name: 'Estilo Feitiço', registration_number: '23743693000108', address: 'Avenida João Pessoa, 5252', city: 'Fortaleza', state: 'CE', email: 'contato@estilofeitico.com')

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Estilo Feitiço'
    click_on 'Editar'
    fill_in 'Razão Social', with: 'Sanchez Cano LTDA'
    fill_in 'Nome Fantasia', with: 'The Fini Company Brasil'
    fill_in 'CNPJ', with: '03594123001168'
    fill_in 'Endereço', with: 'Avenida José Benassi, 1503'
    fill_in 'Cidade', with: 'Jundiaí'
    fill_in 'Estado', with: 'SP'
    fill_in 'Email', with: 'sac@finicompany.com'
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq(supplier_path(supplier.id))
    expect(page).to have_content('Fornecedor atualizado com sucesso')

    expect(page).to have_content('Fornecedor The Fini Company Brasil')
    expect(page).to have_content('Sanchez Cano LTDA')
    expect(page).to have_content('CNPJ:')
    expect(page).to have_content('03594123001168')
    expect(page).to have_content('Endereço:')
    expect(page).to have_content('Avenida José Benassi, 1503 - Jundiaí - SP')
    expect(page).to have_content('Email:')
    expect(page).to have_content('sac@finicompany.com')
  end

  it 'e mantém os campos obrigatórios' do
    # Arrange
    supplier = Supplier.create!(corporate_name: 'Fateixa Confeccoes LTDA', brand_name: 'Estilo Feitiço', registration_number: '23743693000108', address: 'Avenida João Pessoa, 5252', city: 'Fortaleza', state: 'CE', email: 'contato@estilofeitico.com')

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Estilo Feitiço'
    click_on 'Editar'
    fill_in 'Razão Social', with: ''
    fill_in 'Nome Fantasia', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Email', with: ''
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq(supplier_path(supplier.id))
    expect(page).to have_content('Não foi possível atualizar o fornecedor')
  end

end
