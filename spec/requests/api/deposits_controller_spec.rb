require "rails_helper"

RSpec.describe "Api::DepositsController", type: :request do 
  subject(:buyer_user) { create(:buyer, deposit: 200) }
  subject(:seller_user) { create(:seller) }
  let(:buyer_token) { AccessToken.encode(user_id: buyer_user.id) }
  let(:seller_token) { AccessToken.encode(user_id: seller_user.id) }


  let(:seller_headers) do 
    {"ACCEPT" => "application/json", 
    'Authorization' => seller_token}
  end

  let(:buyer_headers) do 
    {"ACCEPT" => "application/json", 
    'Authorization' => buyer_token}
  end

  context "GET deposit for unathorized user" do
    before { get api_deposit_path }

    it { expect(response).to have_http_status(:unauthorized) }
    it { expect(JSON.parse(response.body)["errors"]).to eq("you must be logged in") }
  end

  context "GET deposit for authorized user" do
    before { get api_deposit_path, headers: buyer_headers }

    it { expect(response).to have_http_status(:ok) }
    it { expect(JSON.parse(response.body)["message"]).to eq("Your wallet")}
    it { expect(JSON.parse(response.body)["deposit"]).to eq(buyer_user.deposit) }
  end

  context "PATCH deposit" do
    before { patch api_deposit_path, params: { give_coin: 10 }, headers: buyer_headers }

    it { expect(response).to have_http_status(:ok) }
    it { expect(JSON.parse(response.body)["message"]).to eq("successfull")}
    it { expect(JSON.parse(response.body)["deposit"]).to eq(buyer_user.deposit + 10) }
  end

  context "DELETE reset" do
    before { delete api_reset_path, headers: buyer_headers }
    
    it { expect(response).to have_http_status(:success) }
    it { expect(JSON.parse(response.body)["message"]).to eq("updated")}
    it { expect(JSON.parse(response.body)["deposit"]).to eq(0) }
  end

  context "POST buy" do
    let(:new_product) { create(:product, cost: 50,  amount_available: 2)}
    before { post api_buy_path, params: { amount: 1, product_id: new_product.id }, headers: buyer_headers }

    it { expect(response).to have_http_status(:success) }
    it { expect(JSON.parse(response.body)["message"]).to eq("bought: ")}
    it { expect(JSON.parse(response.body)["product"]['id']).to eq(new_product.id) }
    it { expect(JSON.parse(response.body)["total"]).to eq(1 * new_product.cost) }
    it { expect(JSON.parse(response.body)["change"]).to eq([100, 50]) }
  end
end