require 'rails_helper'

RSpec.describe UsersController, type: :controller do
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
      @user = create(:user)
      login_with @user
    end
    
    describe "GET #index" do
      it "shows all users" do
        get :index
        expect(response).to render_template(:index)
      end
      
      it "loads all the users into @users" do
        user1 = User.create!(name: 'Example 2', password: 'secret', email: 'email2@example.com')
        user2 = User.create!(name: 'Example 3', password: 'secret', email: 'email3@example.com')
        get :index
        expect(assigns(:users)).to match_array([@user, user1, user2])
      end
    end
    
    describe 'GET #show' do
      it "shows user page" do
        get :show, id: @user
        expect(response).to render_template(:show)
      end
    end
  end
end