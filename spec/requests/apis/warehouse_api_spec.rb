require 'rails_helper'

describe 'Warehouse API', type: :request do
  context 'GET /api/v1/warehouses/1' do
    it 'success' do
      # Arrange
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
      description: 'Galpão destinado a cargas internacionais')

      # Act
      get "/api/v1/warehouses/#{warehouse.id}"

      # Assert
      expect(response.status).to eq(200)
      expect(response.content_type).to include('application/json')

      json_response = JSON.parse(response.body)

      expect(json_response['name']).to eq('Aeroporto SP')
      expect(json_response['code']).to eq('GRU')
      expect(json_response).not_to include('created_at')
      expect(json_response).not_to include('updated_at')
    end

    it 'failure if warehouse not found' do
      # Arrange

      # Act
      get '/api/v1/warehouses/99999999'

      # Assert
      expect(response.status).to eq(404)
    end
  end

  context 'GET /api/v1/warehouses/' do
    it 'lists all warehouses ordered by name' do
      # Arrange
      Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', state: 'RJ', area: 60_000,
      address: 'Avenida do Porto, 1000', postal_code: '20015-510' , description: 'Galpão do Rio')
      Warehouse.create!(name: 'Maceió', code: 'MCZ', city: 'Maceió', state: 'AL', area: 50_000,
      address: 'Rua do Jacintinho, 75', postal_code: '75195-712', description: 'Galpão do setor industrial')

      # Act
      get '/api/v1/warehouses'

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]['name']).to eq 'Maceió'
      expect(json_response[1]['name']).to eq 'Rio'
    end

    it 'empty if there is no warehouse' do
      # Arrange

      # Act
      get '/api/v1/warehouses'

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end
  end
end