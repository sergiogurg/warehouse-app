# require 'rails_helper'

# describe 'Usuário edita um fornecedor' do
#   it 'a partir da página de detalhes' do
#     # Arrange
#     supplier = Supplier.create!(corporate_name: 'M Dias Branco S.A. Indústria e Comércio de Alimentos', brand_name: 'Fábrica Fortaleza', registration_number: '07206816000115', address: 'BR 116, km 18', city: 'Eusébio', state: 'CE', email: 'sac@mdiasbranco.com.br')

#     # Act
#     visit root_path
#     click_on 'Fornecedores'
#     click_on 'Fábrica Fortaleza'
#     click_on 'Editar'

#     # Assert
#     expect(page).to have_content('Editar Fornecedor')

#     expect(page).to have_field('Razão Social', with: 'Fábrica Fortaleza')
#     expect(page).to have_field('Nome Fantasia', with: 'M Dias Branco S.A. Indústria e Comércio de Alimentos')
#     expect(page).to have_field('CNPJ', with: '07206816000115')
#     expect(page).to have_field('Endereço', with: 'BR 116, km 18')
#     expect(page).to have_field('Cidade', with: 'Eusébio')
#     expect(page).to have_field('Estado', with: 'CE')
#     expect(page).to have_field('Email', with: 'sac@mdiasbranco.com.br')
#   end

#   # it 'com sucesso' do
#   # end

#   # it 'e mantém os campos obrigatórios' do
#   # end

# end
