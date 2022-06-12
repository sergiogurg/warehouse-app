require 'rails_helper'

describe 'Usuário vê estoque' do
  it 'na página de um galpão' do
    # Arrange
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
      description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Dell Technologies LTDA', brand_name: 'Dell', registration_number: '72381189000110', address: 'Avenida da Emancipação, 5000', city: 'Hortolandia', state: 'SP', email: 'contato@dell.com')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now)
    product_a = ProductModel.create!(name: 'TV 32', weight: 8000, length: 70, width: 10, height: 45, sku: 'TV32-SAMSU-XPTO90', supplier: supplier)
    product_b = ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, length: 80, width: 20, height: 15, sku: 'SOUND-SAMSU-NOIZ77', supplier: supplier)
    product_c = ProductModel.create!(supplier: supplier, name: 'Cadeira Gamer', weight: 5, length: 70, height: 100, width: 75, sku: 'CAD-GAMER-1234')
    
    3.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_a) }
    2.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_c) }
    
    # Act
    login_as user
    visit root_path
    click_on 'Aeroporto SP'

    # Assert
    expect(page).to have_content('Itens em Estoque')
    expect(page).to have_content('3 x TV32-SAMSU-XPTO90')
    expect(page).to have_content('2 x CAD-GAMER-1234')
    expect(page).not_to have_content('SOUND-SAMSU-NOIZ77')
  end

  it 'e dá baixa em um item' do
    # Arrange
    user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', postal_code: '15000-000',
      description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(corporate_name: 'Dell Technologies LTDA', brand_name: 'Dell', registration_number: '72381189000110', address: 'Avenida da Emancipação, 5000', city: 'Hortolandia', state: 'SP', email: 'contato@dell.com')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now)
    product = ProductModel.create!(name: 'TV 32', weight: 8000, length: 70, width: 10, height: 45, sku: 'TV32-SAMSU-XPTO90', supplier: supplier)

    2.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product) }

    # Act
    login_as(user)
    visit root_path
    click_on 'Aeroporto SP'
    select 'TV32-SAMSU-XPTO90', from: 'Item para Saída'
    fill_in 'Destinatário', with: 'Maria Ferreira'
    fill_in 'Endereço', with: 'Rua das Palmeiras, 100, Campinas - SP'
    click_on 'Confirmar Retirada'

    # Assert
    expect(current_path).to eq(warehouse_path(warehouse.id))
    expect(page).to have_content('Item retirado com sucesso')
    expect(page).to have_content('1 x TV32-SAMSU-XPTO90')
  end
end