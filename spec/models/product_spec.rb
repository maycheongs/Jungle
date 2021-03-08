require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'Saves successfully' do
    @household = Category.create(name: "Household")
    @product = Product.new(name: "Mop", category_id: @household[:id], quantity: 11, price: 6)

    expect(@product.save).to be_truthy

  end
  describe 'Validations' do    

    it 'validates name' do
      @household = Category.create(name: "Household")
      @product = Product.new(name: nil, category_id: @household[:id], quantity: 11, price: 6)

      expect(@product.save).to be_falsey
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it 'validates price' do
      @household = Category.create(name: "Household")
      @product = Product.new(name: "Mop", category_id: @household[:id], quantity: 11, price: nil)

      expect(@product.save).to be_falsey
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    it 'validates quantity' do
      @household = Category.create(name: "Household")
      @product = Product.new(name: "Mop", category_id: @household[:id], quantity: nil, price: 6)

      expect(@product.save).to be_falsey
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it 'validates category' do
      @household = Category.create(name: "Household")
      @product = Product.new(name: "Mop", category_id: nil, quantity: 11, price: 6)

      expect(@product.save).to be_falsey
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
