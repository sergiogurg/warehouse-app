require 'rails_helper'

describe 'Usuário edita um pedido' do
  it 'mas o pedido não lhe pertence' do
    # Arrange
    andre = User.create!(name: 'André', email: 'andre@email.com', password: 'password')
    joao = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
      description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'M Dias Branco S.A. Indústria e Comércio de Alimentos', brand_name: 'Fábrica Fortaleza', registration_number: '07206816000115', address: 'BR 116, km 18', city: 'Eusébio', state: 'CE', email: 'sac@mdiasbranco.com.br')
    order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    
    # Act
    login_as(andre)
    patch(order_path(order.id), params: { order: { supplier_id: 3 } })

    # Assert
    expect(response).to redirect_to(root_path)
  end
end