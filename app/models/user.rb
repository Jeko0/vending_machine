class User < ApplicationRecord
  has_many :products, foreign_key: "seller_id", dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :user_name, presence: true, allow_blank: false, uniqueness: true
  validates :deposit, presence: true, numericality: { greater_than_or_equal_to: 0 }

  enum role: %i[ buyer seller ]
  after_create :set_user_role 

  def set_user_role
    self.role ||= :buyer
  end
end
