require "rails_helper" 

RSpec.describe User, type: :model do 
  context "Associations" do 
    it { should have_many(:products).dependent(:destroy).with_foreign_key(:seller_id) } 
  end

  context "Validations" do 
    it { should validate_presence_of(:user_name) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_length_of(:password).is_at_least(6).on(:create) }
    it { should validate_confirmation_of(:password) }
    it { should validate_presence_of(:deposit) }
    it { should validate_numericality_of(:deposit).is_greater_than_or_equal_to(0) }
  end
end