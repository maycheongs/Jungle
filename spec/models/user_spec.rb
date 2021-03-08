require 'rails_helper'

RSpec.describe User, type: :model do
  it 'Saves a new user' do
    @user =
      User.new(
        name: 'Bobthebuilder',
        password: 'password',
        password_confirmation: 'password',
        email: 'bob@bob.com',
      )
    expect(@user.save).to be_truthy
  end
  # describe 'Validations' do
  #   it ''
  # end
end
