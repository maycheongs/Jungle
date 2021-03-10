class Order < ActiveRecord::Base
  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  after_create :update_product_quantities

  def update_product_quantities
    line_items.each do |line_item|
      @product = line_item.product
      @product.update_attributes(
        quantity: (@product.quantity - line_item.quantity),
      )
    end
  end
end
