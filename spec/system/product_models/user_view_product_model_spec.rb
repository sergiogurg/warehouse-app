require 'rails_helper'

describe 'Usuário vê modelos de produtos' do
  it 'somente se estiver autenticado' do
    # Arrange

    # Act
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end

    # Assert
    expect(current_path).to eq(new_user_session_path)
  end

  it 'a partir do menu' do
    # Arrange
    user = User.create!(email: 'vittar@yuke.com', password: 'yuke123')

    # Act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end
    
    # Assert
    expect(current_path).to eq(product_models_path)
  end

  it 'com sucesso' do
    # Arrange
    user = User.create!(email: 'vittar@yuke.com', password: 'yuke123')

    supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', registration_number: '12345678912345', address: 'Avenida das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

    ProductModel.create!(name: 'TV 32', weight: 8000, length: 70, width: 10, height: 45, sku: 'TV32-SAMSU-XPTO90', supplier: supplier)
    ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, length: 80, width: 20, height: 15, sku: 'SOUND-SAMSU-NOIZ77', supplier: supplier)

    # Act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end

    # Assert
    expect(page).to have_content('TV 32')
    expect(page).to have_content('TV32-SAMSU-XPTO90')
    expect(page).to have_content('Samsung')
    expect(page).to have_content('SoundBar 7.1 Surround')
    expect(page).to have_content('SOUND-SAMSU-NOIZ77')
    expect(page).to have_content('Samsung')
  end

  it 'e não existem modelos de produtos cadastrados' do
    # Arrange
    user = User.create!(email: 'vittar@yuke.com', password: 'yuke123')

    # Act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Modelos de Produtos'
    end

    # Assert
    expect(page).to have_content('Nenhum modelo de produto cadastrado.')
  end
end