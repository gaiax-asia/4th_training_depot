class StoreController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_cart
  include CurrentCart
  
  def index
    if params[:set_locale]
      redirect_to store_url(locale: params[:set_locale])
    else
      unless params[:category_search].blank?
        @products = Product.where(category: params[:category_search]).paginate(page: params[:page], per_page: 3)
      else
        @products = Product.paginate(page: params[:page], per_page: 3)
      end
    end
  end
  
  def refresh_cart
  end
end
