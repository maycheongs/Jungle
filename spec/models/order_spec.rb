require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      cat1 = Category.create!({ name: 'Apparel' })

      @product1 =
        cat1.products.create!(
          {
            name: 'Men\'s Classy shirt',
            description: Faker::Hipster.paragraph(4),
            image: open_asset('apparel1.jpg'),
            quantity: 1,
            price: 64.99,
          },
        )

      @product2 =
        cat1.products.create!(
          {
            name: 'Women\'s Zebra pants',
            description: Faker::Hipster.paragraph(4),
            image: open_asset('apparel2.jpg'),
            quantity: 18,
            price: 124.99,
          },
        )
    end

    it 'deducts quantity from products based on their line item quantities' do
      @order =
        Order.new(email: 'a@a.com', total_cents: 12_499, stripe_charge_id: 1)
      @order.line_items.new(
        product: @product2,
        quantity: 1,
        item_price: @product2.price,
        total_price: @product2.price * 1,
      )
      @order.line_items.new(
        product: @product1,
        quantity: 1,
        item_price: @product1.price,
        total_price: @product1.price * 1,
      )
      @order.save!
      @product1.reload
      @product2.reload
      puts @order.errors.full_messages

      expect(@product2.quantity).to eq(17)
      expect(@product1.quantity).to eq(0)
    end
    it 'deducts quantity from products based on their line item quantities' do
      @order =
        Order.new(email: 'a@a.com', total_cents: 12_499, stripe_charge_id: 1)
      @order.line_items.new(
        product: @product2,
        quantity: 1,
        item_price: @product2.price,
        total_price: @product2.price * 1,
      )
      @order.save!
      @product1.reload
      @product2.reload
      puts @order.errors.full_messages

      expect(@product1.quantity).to eq(1)
    end
  end
end
