class Product < ApplicationRecord
  belongs_to :seller, class_name: "User", foreign_key: "seller_id"

  validates :product_name, presence: true
  validates :amount_available, presence: true
  validates :cost, presence: true
end
