require 'rails_helper'

RSpec.feature 'ProductDetails', type: :feature, js: true do
  #SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        price: 64.99,
        image: open_asset('apparel1.jpg'),
      )
    end
    visit root_path
    page.first('.product a').click
  end

  scenario 'sees product' do
    sleep 1

    expect(page).to have_css 'article.product-detail'
  end
end
