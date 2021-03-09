require 'rails_helper'

RSpec.feature 'UserLogins', type: :feature, js: true do
  #SETUP
  before :each do
    User.create!(
      first_name: 'Bob',
      last_name: 'Builder',
      email: 'test@test.com',
      password: 'password',
      password_confirmation: 'password',
    )

    visit login_path
  end

  scenario 'users can log in' do
    fill_in 'session_email', with: 'test@test.com'
    fill_in 'session_password', with: 'password'

    click_button('Log in')

    expect(page).to have_content('Logged in as Bob')
  end
end
