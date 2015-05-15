require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
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
      login_with create(:user)
      @category = Category.create!(name: 'Fiction')
    end
    
    describe "GET #index" do
      it "shows all categories" do
        get :index
        expect(response).to render_template(:index)
      end
      
      it "loads all the categories into @categories" do
        category1 = Category.create!(name: 'Education')
        category2 = Category.create!(name: 'Non-fiction')
        get :index
        expect(assigns(:categories)).to match_array([@category, category1, category2])
      end
    end
    
    describe "GET #new" do
      it "renders new page" do
        get :new
        expect(response).to render_template(:new)
      end
    end
    
    describe 'POST #create' do
      it "creates a category" do
        expect do
          post :create, category: {name: 'Romance'}
        end.to change{ Category.count }.by 1
        
        expect(response).to redirect_to categories_path
      end
    end
    
    describe 'GET #edit' do
      it "renders edit page" do
        get :edit, id: @category
        expect(response).to render_template(:edit)
      end
    end
    
    describe 'PATCH #update' do
      it "updates a category" do
        patch :update, id: @category, category: {name: 'General Fiction'}
        expect(response).to redirect_to categories_path
      end
    end
    
    describe 'DELETE #destroy' do
      it "deletes the category" do
        expect do
          delete :destroy, id: @category
        end.to change{ Category.count }.by -1
        
        expect(response).to redirect_to categories_path
      end
    end
    
  end
end