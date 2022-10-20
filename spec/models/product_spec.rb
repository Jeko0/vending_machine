require "rails_helper" 

RSpec.describe Product, type: :model do 
  context "Associations" do 
    it { should belong_to(:seller).class_name('User').with_foreign_key(:seller_id) }
  end

  context "Validations" do 
    it { should validate_presence_of(:product_name) }
    it { should validate_presence_of(:amount_available) }
    it { should validate_presence_of(:cost) }
  end
end