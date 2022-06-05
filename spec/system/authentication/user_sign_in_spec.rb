require 'rails_helper'

describe 'Usuário se autentica (faz login)' do
  it 'com sucesso' do
    # Arrange
    User.create!(name: 'Pabllo Vittar', email: 'vittar@yuke.com', password: 'yuke123')

    # Act
    visit root_path
    click_on 'Fazer Login'
    within('form') do
      fill_in 'E-mail', with: 'vittar@yuke.com'
      fill_in 'Senha', with: 'yuke123'
      click_on 'Entrar'
    end

    # Assert
    expect(page).to have_content('Login efetuado com sucesso.')
    within('nav') do
      expect(page).not_to have_link('Fazer Login')
      expect(page).to have_button('Sair')
      expect(page).to have_content('Pabllo Vittar - <vittar@yuke.com>')
    end
  end

  it 'e encerra a sessão (faz logout)' do
    # Arrange
    User.create!(email: 'vittar@yuke.com', password: 'yuke123')

    # Act
    visit root_path
    click_on 'Fazer Login'
    within('form') do
      fill_in 'E-mail', with: 'vittar@yuke.com'
      fill_in 'Senha', with: 'yuke123'
      click_on 'Entrar'
    end
    click_on 'Sair'

    # Assert
    expect(page).to have_content('Logout efetuado com sucesso.')
    expect(page).to have_link('Fazer Login')
    expect(page).not_to have_button('Sair')
    expect(page).not_to have_content('vittar@yuke.com')
  end
end