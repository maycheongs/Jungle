class Review < ActiveRecord::Base
  validates :product, presence: true
  validates :user, presence:true
  validates :rating, presence:true, numericality: {only_integer: true}, inclusion: 1..5
  validates :description, presence:true
  belongs_to :product
  belongs_to :user
end
