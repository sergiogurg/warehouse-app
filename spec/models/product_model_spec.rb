require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'falso quando Nome estiver em branco' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', registration_number: '12345678912345', address: 'Avenida das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
        pm = ProductModel.new(name: '', weight: 8000, length: 70, width: 10, height: 45, sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

        # Act and Assert
        expect(pm).not_to be_valid
      end

      it 'falso quando SKU estiver em branco' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', registration_number: '12345678912345', address: 'Avenida das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
        pm = ProductModel.new(name: 'TV 32', weight: 8000, length: 70, width: 10, height: 45, sku: '', supplier: supplier)

        # Act and Assert
        expect(pm).not_to be_valid
      end

      it 'falso quando Peso estiver em branco' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', registration_number: '12345678912345', address: 'Avenida das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
        pm = ProductModel.new(name: 'TV 32', weight: '', length: 70, width: 10, height: 45, sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

        # Act and Assert
        expect(pm).not_to be_valid
      end

      it 'falso quando Comprimento estiver em branco' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', registration_number: '12345678912345', address: 'Avenida das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
        pm = ProductModel.new(name: 'TV 32', weight: 8000, length: '', width: 10, height: 45, sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

        # Act and Assert
        expect(pm).not_to be_valid
      end

      it 'falso quando Altura estiver em branco' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', registration_number: '12345678912345', address: 'Avenida das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
        pm = ProductModel.new(name: 'TV 32', weight: 8000, length: 70, width: 10, height: '', sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

        # Act and Assert
        expect(pm).not_to be_valid
      end

      it 'falso quando Largura estiver em branco' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', registration_number: '12345678912345', address: 'Avenida das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
        pm = ProductModel.new(name: 'TV 32', weight: 8000, length: 70, width: '', height: 45, sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

        # Act and Assert
        expect(pm).not_to be_valid
      end

      it 'falso quando Fornecedor estiver em branco' do
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', registration_number: '12345678912345', address: 'Avenida das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
        pm = ProductModel.new(name: 'TV 32', weight: 8000, length: 70, width: 10, height: 45, sku: 'TV32-SAMSU-XPTO90', supplier: nil)

        # Act and Assert
        expect(pm).not_to be_valid
      end
    end
  end
end
