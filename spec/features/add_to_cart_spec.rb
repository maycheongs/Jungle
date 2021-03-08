require 'rails_helper'

RSpec.feature 'AddToCarts', type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    5.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        price: 64.99,
        image: open_asset('apparel1.jpg'),
      )
    end
    visit root_path
  end
  scenario 'Cart increments with each add' do
    page.first('.product').click_button('Add')
    sleep 1
    cart = page.find_link('My Cart')
    expect(cart).to have_content('1')
  end
end
