require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#description' do
    it 'exibe o nome e o email' do
      # Arrange
      user = User.new(name: 'Julia Almeida', email: 'julia@yahoo.com.br')

      # Act
      result = user.description()

      # Assert
      expect(result).to eq('Julia Almeida - <julia@yahoo.com.br>')

    end
  end
end
