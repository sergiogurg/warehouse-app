require 'rails_helper'

describe 'Usuario visita tela inicial' do
  it 'e vê o nome da app' do
    # Arrange

    # Act
    visit(root_path)

    # Assert
    expect(page).to have_content('Sistema de Galpões e Estoque')
    expect(page).to have_link('Sistema de Galpões e Estoque', href: root_path)
  end

  it 'e vê os galpões cadastrados' do
    # Arrange
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', state: 'RJ', area: 60_000,
                    address: 'Avenida do Porto, 1000', postal_code: '20015-510' , description: 'Galpão do Rio')
    Warehouse.create!(name: 'Maceió', code: 'MCZ', city: 'Maceió', state: 'AL', area: 50_000,
                    address: 'Rua do Jacintinho, 75', postal_code: '75195-712', description: 'Galpão do setor industrial')

    # Act
    visit(root_path)

    # Assert
    expect(page).not_to have_content('Não existem galpões cadastrados')

    expect(page).to have_content('Rio')
    expect(page).to have_content('Código: SDU')
    expect(page).to have_content('Cidade: Rio de Janeiro')
    expect(page).to have_content('Estado: RJ')
    expect(page).to have_content('60000 m²')

    expect(page).to have_content('Maceió')
    expect(page).to have_content('Código: MCZ')
    expect(page).to have_content('Cidade: Maceió')
    expect(page).to have_content('Estado: AL')
    expect(page).to have_content('50000 m²')
  end

  it 'e não existem galpões cadastrados' do
    # Arrange

    # Act
    visit(root_path)

    # Assert
    expect(page).to have_content('Não existem galpões cadastrados')

  end

end
