class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :user_name, presence: true, uniqueness: true

  enum role: %i[ buyer seller ]
  after_create :set_user_role 

  def set_user_role
    self.role ||= :buyer
  end
end
