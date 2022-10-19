class User < ApplicationRecord
  has_many :products, foreign_key: "seller_id", dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :user_name, presence: true, uniqueness: true
  validates :deposit, presence: true, 

  enum role: %i[ buyer seller ]
  after_create :set_user_role 

  

  def set_user_role
    self.role ||= :buyer
  end
end
