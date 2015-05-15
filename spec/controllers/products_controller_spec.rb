require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe "anonymous user" do
    before :each do
      login_with nil
    end
    
    describe "GET #index" do
      it "should be redirected to signin" do
        get :index
        expect( response ).to redirect_to( new_user_session_path(locale: nil) )
      end
    end
    
  end
  
  describe "logged in user" do
    before :each do
      login_with User.create!(name: 'Example', password: 'secret', email: 'email@example.com')
      @product = Product.create!(title: 'Test', description: 'Test', image_url: 'test.jpg', price: 11, category_id: 1)
    end
    
    describe "GET #index" do
      it "shows all products" do
        get :index
        expect(response).to render_template(:index)
      end
      
      it "loads all the products into @products" do
        product1 = create_product('example', 'example', 'ex.jpg', 1, 11)
        product2 = create_product('example 2', 'example', 'ex.png', 1, 11)
        get :index
        expect(assigns(:products)).to match_array([@product, product1, product2])
      end
    end
    
    describe "GET #new" do
      it "renders new page" do
        get :new
        expect(response).to render_template(:new)
      end
    end
    
    describe 'POST #create' do
      it "creates a product" do
        expect do
          post :create, product: {title: 'Test Two', description: 'Test', image_url: 'test.jpg', price: 11, category_id: 1}
        end.to change{ Product.count }.by 1
        
        expect(response).to redirect_to product_path(assigns(:product))
      end
    end
    
    describe 'GET #show' do
      it "shows product page" do
        get :show, id: @product
        expect(response).to render_template(:show)
      end
    end
    
    describe 'GET #edit' do
      it "renders edit page" do
        get :edit, id: @product
        expect(response).to render_template(:edit)
      end
    end
    
    describe 'PATCH #update' do
      it "updates a product" do
        patch :update, id: @product, product: {title: 'Test Two', description: 'Test', image_url: 'test.jpg', price: 11, category_id: 1}
        expect(response).to redirect_to product_path(assigns(:product))
      end
    end
    
    describe 'DELETE #destroy' do
      it "deletes the product" do
        expect do
          delete :destroy, id: @product
        end.to change{ Product.count }.by -1
        
        expect(response).to redirect_to products_path
      end
    end
    
  end
end