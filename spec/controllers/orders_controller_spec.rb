require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
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
      @order = Order.create!(name: 'Example', email: 'example@example.com', address: 'example', pay_type: 'Check')
    end
    
    describe "GET #index" do
      it "shows all orders" do
        get :index
        expect(response).to render_template(:index)
      end
      
      it "loads all the orders into @orders" do
        order1 = Order.create!(name: 'Example 1', email: 'example@example.com', address: 'example', pay_type: 'Check')
        order2 = Order.create!(name: 'Example 2', email: 'example@example.com', address: 'example', pay_type: 'Check')
        get :index
        expect(assigns(:orders)).to match_array([@order, order1, order2])
      end
    end
    
    describe "GET #new" do
      it "renders new page" do
        get :new
        expect(response).to redirect_to store_url
      end
    end
    
    describe 'POST #create' do
      it "creates an order" do
        expect do
          post :create, order: {name: 'Example 1', email: 'example@example.com', address: 'example', pay_type: 'Check'}
        end.to change{ Order.count }.by 1
        
        expect(response).to redirect_to store_url
      end
    end
    
    describe 'GET #show' do
      it "shows orders page" do
        get :show, id: @order
        expect(response).to render_template(:show)
      end
    end
    
    describe 'GET #edit' do
      it "renders edit page" do
        get :edit, id: @order
        expect(response).to render_template(:edit)
      end
    end
    
    describe 'PATCH #update' do
      it "updates an order" do
        patch :update, id: @order, order: {name: 'Example 1', email: 'example@example.com', address: 'example', pay_type: 'Credit card'}
        expect(response).to redirect_to order_path(assigns(:order))
      end
    end
    
    describe 'DELETE #destroy' do
      it "deletes the order" do
        expect do
          delete :destroy, id: @order
        end.to change{ Order.count }.by -1
        
        expect(response).to redirect_to orders_path
      end
    end
    
  end
end