require 'rails_helper'

RSpec.describe StoreController, type: :controller do
  
  
  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
    
    it "loads all the products into @products" do
      product1 = create_product('example', 'example', 'ex.jpg', 1, 11)
      product2 = create_product('example 2', 'example', 'ex.png', 1, 11)
      get :index
      expect(assigns(:products)).to match_array([product1, product2])
    end
  end
end
