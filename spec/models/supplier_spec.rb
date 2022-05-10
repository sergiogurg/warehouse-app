# require 'rails_helper'

# RSpec.describe Supplier, type: :model do
#   describe '#valid?' do
#     context 'presence' do
#       it 'false when corporate_name is empty' do
#         # Arrange
#         supplier = Suppliers.new(corporate_name: '', brand_name: 'Beats', registration_number: '612596515755', address: 'Avenida das Pocs, 616', city: 'São Paulo', state: 'SP', email: 'sac-loja@beatsoficial.com.br')

#         # Act and Assert
#         expect(supplier).not_to be_valid
#       end
#       it 'false when brand_name is empty' do
#         # Arrange
#         supplier = Suppliers.new(corporate_name: 'Beats Bebidas Mistas LTDA', brand_name: '', registration_number: '612596515755', address: 'Avenida das Pocs, 616', city: 'São Paulo', state: 'SP', email: 'sac-loja@beatsoficial.com.br')

#         # Act and Assert
#         expect(supplier).not_to be_valid
#       end
#       it 'false when registration_number is empty' do
#         # Arrange
#         supplier = Suppliers.new(corporate_name: 'Beats Bebidas Mistas LTDA', brand_name: 'Beats', registration_number: '', address: 'Avenida das Pocs, 616', city: 'São Paulo', state: 'SP', email: 'sac-loja@beatsoficial.com.br')

#         # Act and Assert
#         expect(supplier).not_to be_valid
#       end
#       it 'false when email is empty' do
#         # Arrange
#         supplier = Suppliers.new(corporate_name: 'Beats Bebidas Mistas LTDA', brand_name: 'Beats', registration_number: '612596515755', address: 'Avenida das Pocs, 616', city: 'São Paulo', state: 'SP', email: '')

#         # Act and Assert
#         expect(supplier).not_to be_valid
#       end
#     end
#   end
# end
