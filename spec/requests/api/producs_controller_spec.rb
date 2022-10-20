require "rails_helper"

RSpec.describe "Api::ProductsController", type: :request do
  subject(:buyer_user) { create(:buyer) }
  subject(:seller_user) { create(:seller) }
  let(:buyer_token) { AccessToken.encode(user_id: buyer_user.id) }
  let(:seller_token) { AccessToken.encode(user_id: seller_user.id) }
  

  let(:valid_headers) do 
    {"ACCEPT" => "application/json", 
    'Authorization' => seller_token}
  end

  let(:invalid_headers) do 
    {"ACCEPT" => "application/json", 
    'Authorization' => buyer_token}
  end

  context "GET index" do
    it "shows all available products" do 
      get api_products_path, headers: headers  
      expect(response).to be_successful
    end
  end

  context "GET show" do
    it "shows specific product" do 
      product = create(:product)
      get api_path(product), headers: valid_headers
      expect(response).to  have_http_status(:success)
    end
  end

  context "POST create" do
    it "asks user to be signed in" do 
      post api_products_path
      expect(response).to have_http_status(:unauthorized)
    end

    it "creates product" do 
      product = attributes_for(:product)
      post api_products_path, params: { product: product }, headers: valid_headers
      expect(response).to have_http_status(:success)
    end

    it "does not create product" do 
      post api_products_path, headers: invalid_headers
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "PATCH update" do 
    let(:product) { create(:product) }
    let(:product_id) { product.id }
    let(:root) { "/api/products/" + product_id.to_s }
    before { patch root, params: { product: { product_name: "new product"} },  headers: valid_headers
      product.reload
    }

    it "updates product" do 
      expect(product.product_name).to eq("new product") 
      expect(JSON.parse(response.body)["message"]).to eq("product updated")
      expect(response.status).to eq 200 
    end
  end

  context "DELETE destroy" do
    let(:product) { create(:product) }
    let(:product_id) { product.id }
    let(:root) { "/api/products/" + product_id.to_s }
    before { delete root, params: { product: { product_name: "new product"} },  headers: valid_headers
    product.destroy
    }

    it "deletes product" do 
      expect(JSON.parse(response.body)["message"]).to eq("product deleted") 
      expect(response.status).to eq 200 
    end
  end
end