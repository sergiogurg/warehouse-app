require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'falso quando corporate_name estiver vazio' do
        # Arrange
        supplier = Supplier.new(corporate_name: '', brand_name: 'Beats', registration_number: '15427207000203', address: 'Avenida das Pocs, 616', city: 'São Paulo', state: 'SP', email: 'sac-loja@beatsoficial.com.br')

        # Act and Assert
        expect(supplier).not_to be_valid
      end
      it 'falso quando brand_name estiver vazio' do
        # Arrange
        supplier = Supplier.new(corporate_name: 'Beats Bebidas Mistas LTDA', brand_name: '', registration_number: '15427207000203', address: 'Avenida das Pocs, 616', city: 'São Paulo', state: 'SP', email: 'sac-loja@beatsoficial.com.br')

        # Act and Assert
        expect(supplier).not_to be_valid
      end
      it 'falso quando registration_number estiver vazio' do
        # Arrange
        supplier = Supplier.new(corporate_name: 'Beats Bebidas Mistas LTDA', brand_name: 'Beats', registration_number: '', address: 'Avenida das Pocs, 616', city: 'São Paulo', state: 'SP', email: 'sac-loja@beatsoficial.com.br')

        # Act and Assert
        expect(supplier).not_to be_valid
      end
      it 'falso quando email estiver vazio' do
        # Arrange
        supplier = Supplier.new(corporate_name: 'Beats Bebidas Mistas LTDA', brand_name: 'Beats', registration_number: '15427207000203', address: 'Avenida das Pocs, 616', city: 'São Paulo', state: 'SP', email: '')

        # Act and Assert
        expect(supplier).not_to be_valid
      end
    end

    context 'uniqueness' do
      it 'falso quando houver dois ou mais fornecedores com CNPJ iguais' do
      # Arrange
      first_supplier = Supplier.create!(corporate_name: 'Beats Bebidas Mistas LTDA', brand_name: 'Beats', registration_number: '12345678912345', address: 'Avenida das Pocs, 616', city: 'São Paulo', state: 'SP', email: 'sac-loja@beatsoficial.com.br')
      second_supplier = Supplier.new(corporate_name: 'Fateixa Confeccoes LTDA', brand_name: 'Estilo Feitiço', registration_number: '12345678912345', address: 'Avenida João Pessoa, 5252', city: 'Fortaleza', state: 'CE', email: 'contato@estilofeitico.com')

      # Act and Assert
      expect(second_supplier).not_to be_valid

      end
    end

    context 'format' do
      it 'falso quando o CNPJ não tiver 14 dígitos' do
        # Arrange
        supplier = Supplier.new(corporate_name: 'Beats Bebidas Mistas LTDA', brand_name: 'Beats', registration_number: '123', address: 'Avenida das Pocs, 616', city: 'São Paulo', state: 'SP', email: 'sac-loja@beatsoficial.com.br')

        # Act and Assert
        expect(supplier).not_to be_valid
      end
    end
  end
end
