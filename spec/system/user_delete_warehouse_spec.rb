require 'rails_helper'

describe 'Usuário remove um galpão' do
  it 'com sucesso' do
    # Arrange
    w = Warehouse.create!(name: 'Cuiaba', code: 'CWB', city: 'Cuiabá', state: 'MT', postal_code: '51591-109', address: 'rua Jota Oliveira, 61', area: 10_000, description: 'Galpão no centro do país')

    # Act
    visit root_path
    click_on 'Cuiaba'
    click_on 'Remover'

    # Assert
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Galpão removido com sucesso')
    expect(page).not_to have_content('Cuiaba')
    expect(page).not_to have_content('CWB')
    expect(page).not_to have_content('Cuaiabá')
    expect(page).not_to have_content('MT')
    expect(page).not_to have_content('10000')
  end

  it 'e não remove outros galpões' do
    # Arrange
    first_warehouse = Warehouse.create!(name: 'Cuiaba', code: 'CWB', city: 'Cuiabá', state: 'MT', postal_code: '51591-109', address: 'rua Jota Oliveira, 61', area: 10_000, description: 'Galpão no centro do país')
    second_warehouse = Warehouse.create!(name: 'Belo Horizonte', code: 'BHO', city: 'Belo Horizonte', state: 'MG', postal_code: '22581-150', address: 'avenida das Tulipas, 15', area: 75_000, description: 'Galpão principal da zona norte de Belo Horizonte')

    # Act
    visit root_path
    click_on 'Cuiaba'
    click_on 'Remover'

    # Assert
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Galpão removido com sucesso')
    expect(page).to have_content('Belo Horizonte')
    expect(page).not_to have_content('Cuiaba')
  end
end