class Review < ActiveRecord::Base
  validates 
  belongs_to :product
  belongs_to :user
end
