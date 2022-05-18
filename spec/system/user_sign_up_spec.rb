require 'rails_helper'

describe 'Usuário cria uma conta' do
  it 'com sucesso' do
    # Arrange

    # Act
    visit root_path
    click_on 'Fazer Login'
    click_on 'Criar nova conta'
    fill_in 'Nome', with: 'Vittar'
    fill_in 'E-mail', with: 'vittar@uyke.com'
    fill_in 'Senha', with: 'yuke123'
    fill_in 'Confirme sua senha', with: 'yuke123'
    click_on 'Criar conta'

    # Assert
    expect(page).to have_content('Boas vindas! Você realizou seu registro com sucesso.')
    expect(page).to have_content('vittar@uyke.com')
    expect(page).to have_button('Sair')
    user = User.last
    expect(user.name).to eq('Vittar')
  end
end