require 'rails_helper'

RSpec.describe AdminController, type: :controller do
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
  
  describe "logged-in user" do
    it "render index page" do
      login_with login_with create(:user)
      get :index
      expect(response).to render_template(:index)
    end
  end
end