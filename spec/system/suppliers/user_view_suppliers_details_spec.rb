require 'rails_helper'

describe 'Usuário vê detalhes do fornecedor' do
  it 'e vê detalhes adicionais' do
    # Arrange
    supplier = Supplier.create!(corporate_name: 'M Dias Branco S.A. Indústria e Comércio de Alimentos', brand_name: 'Fábrica Fortaleza', registration_number: '07206816000115', address: 'BR 116, km 18', city: 'Eusébio', state: 'CE', email: 'sac@mdiasbranco.com.br')

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Fábrica Fortaleza'

    # Assert
    expect(page).to have_content('Fornecedor Fábrica Fortaleza')
    expect(page).to have_content('M Dias Branco S.A. Indústria e Comércio de Alimentos')
    expect(page).to have_content('CNPJ:')
    expect(page).to have_content('07206816000115')
    expect(page).to have_content('Endereço:')
    expect(page).to have_content('BR 116, km 18 - Eusébio - CE')
    expect(page).to have_content('Email:')
    expect(page).to have_content('sac@mdiasbranco.com.br')
  end

  it 'e volta para a lista de fornecedores' do
    # Arrange
    supplier = Supplier.create!(corporate_name: 'M Dias Branco S.A. Indústria e Comércio de Alimentos', brand_name: 'Fábrica Fortaleza', registration_number: '07206816000115', address: 'BR 116, km 18', city: 'Eusébio', state: 'CE', email: 'sac@mdiasbranco.com.br')

    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Fábrica Fortaleza'
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq(suppliers_path)

  end
end