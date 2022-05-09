require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do

      it 'false when name is empty' do
        # Arrange
        warehouse = Warehouse.new(name: '', code: 'RIO', city: 'Rio de Janeiro', state: 'RJ', area: 12_000, address: 'Avenida Mata Atlântica, 752', postal_code: '25000-500', description: 'Escreva uma descrição para o galpão')
        # Act
        result = warehouse.valid?
        # Assert
        expect(result).to eq(false)
      end

      it 'false when code is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: '', city: 'Rio de Janeiro', state: 'RJ', area: 12_000, address: 'Avenida Mata Atlântica, 752', postal_code: '25000-500', description: 'Escreva uma descrição para o galpão')
        # Act
        result = warehouse.valid?
        # Assert
        expect(result).to eq(false)
      end

      it 'false when city is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', city: '', state: 'RJ', area: 12_000, address: 'Avenida Mata Atlântica, 752', postal_code: '25000-500', description: 'Escreva uma descrição para o galpão')
        # Act
        result = warehouse.valid?
        # Assert
        expect(result).to eq(false)
      end

      it 'false when state is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', city: 'Rio de Janeiro', state: '', area: 12_000, address: 'Avenida Mata Atlântica, 752', postal_code: '25000-500', description: 'Escreva uma descrição para o galpão')
        # Act
        result = warehouse.valid?
        # Assert
        expect(result).to eq(false)
      end

      it 'false when area is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', city: 'Rio de Janeiro', state: 'RJ', area: '', address: 'Avenida Mata Atlântica, 752', postal_code: '25000-500', description: 'Escreva uma descrição para o galpão')
        # Act
        result = warehouse.valid?
        # Assert
        expect(result).to eq(false)
      end

      it 'false when address is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', city: 'Rio de Janeiro', state: 'RJ', area: 12_000, address: '', postal_code: '25000-500', description: 'Escreva uma descrição para o galpão')
        # Act
        result = warehouse.valid?
        # Assert
        expect(result).to eq(false)
      end

      it 'false when postal_code is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', city: 'Rio de Janeiro', state: 'RJ', area: 12_000, address: 'Avenida Mata Atlântica, 752', postal_code: '', description: 'Escreva uma descrição para o galpão')
        # Act
        result = warehouse.valid?
        # Assert
        expect(result).to eq(false)
      end

      it 'false when description is empty' do
        # Arrange
        warehouse = Warehouse.new(name: 'Rio', code: 'RIO', city: 'Rio de Janeiro', state: 'RJ', area: 12_000, address: 'Avenida Mata Atlântica, 752', postal_code: '25000-500', description: '')
        # Act
        result = warehouse.valid?
        # Assert
        expect(result).to eq(false)
      end

    end

    it 'false when code is already in use' do
      # Arrange
      first_warehouse = Warehouse.create(name: 'Rio', code: 'CODIGO_IGUAL', city: 'Rio de Janeiro',
                                         state: 'RJ', area: 12_000, address: 'Avenida Mata Atlântica, 752',
                                         postal_code: '25000-500', description: 'Escreva uma descrição para o galpão')
      second_warehouse = Warehouse.new(name: 'Niteroi', code: 'CODIGO_IGUAL', city: 'Niterói',
                                       state: 'RJ', area: 8_500, address: 'Avenida Caucaia, 19',
                                       postal_code: '97125-193', description: 'Galpão destinado a produtos agrícolas')

      # Act
      result = second_warehouse.valid?

      # Assert
      expect(result).to eq(false)

    end

  end
end
