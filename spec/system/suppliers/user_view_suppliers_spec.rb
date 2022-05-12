require 'rails_helper'

describe 'Usuário vê fornecedores' do
  it 'a partir do menu' do
    # Arrange

    # Act
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end

    # Assert
    expect(current_path).to eq(suppliers_path)
  end

  it 'com sucesso' do
    # Arrange
    Supplier.create!(corporate_name: 'Beats Bebidas Mistas LTDA', brand_name: 'Beats', registration_number: '15427207000203', address: 'Avenida das Pocs, 616', city: 'São Paulo', state: 'SP', email: 'sac-loja@beatsoficial.com.br')

    Supplier.create!(corporate_name: 'Fateixa Confeccoes LTDA', brand_name: 'Estilo Feitiço', registration_number: '23743693000108', address: 'Avenida João Pessoa, 5252', city: 'Fortaleza', state: 'CE', email: 'contato@estilofeitico.com')

    Supplier.create!(corporate_name: 'Dell Technologies LTDA', brand_name: 'Dell', registration_number: '72381189000110', address: 'Avenida da Emancipação, 5000', city: 'Hortolandia', state: 'SP', email: 'contato@dell.com')

    Supplier.create!(corporate_name: 'M Dias Branco S.A. Indústria e Comércio de Alimentos', brand_name: 'Fábrica Fortaleza', registration_number: '07206816000115', address: 'BR 116, km 18', city: 'Eusébio', state: 'CE', email: 'sac@mdiasbranco.com.br')

    Supplier.create!(corporate_name: 'Sanchez Cano LTDA', brand_name: 'The Fini Company Brasil', registration_number: '03594123001168', address: 'Avenida José Benassi, 1503', city: 'Jundiaí', state: 'SP', email: ' sac@finicompany.com')

    # Act
    visit root_path
    click_on 'Fornecedores'

    # Assert
    within('h2') do
      expect(page).to have_content('Fornecedores')
    end
    expect(page).to have_content('Beats')
    expect(page).to have_content('São Paulo - SP')
    expect(page).to have_content('Estilo Feitiço')
    expect(page).to have_content('Fortaleza - CE')
    expect(page).to have_content('Dell')
    expect(page).to have_content('Hortolandia - SP')
    expect(page).to have_content('Fábrica Fortaleza')
    expect(page).to have_content('Eusébio - CE')
    expect(page).to have_content('The Fini Company Brasil')
    expect(page).to have_content('Jundiaí - SP')
  end

  it 'e não existem fornecedores cadastrados' do
    # Arrange

    # Act
    visit root_path
    click_on 'Fornecedores'

    # Assert
    expect(page).to have_content('Fornecedores')
    expect(page).to have_content('Não existem fornecedores cadastrados.')
  end

  it 'e volta para a tela inicial' do
    # Arrange

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq(root_path)
  end
end
