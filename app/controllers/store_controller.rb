class StoreController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_cart
  include CurrentCart
  
  def index
    if params[:set_locale]
      redirect_to store_url(locale: params[:set_locale])
    else
      #@products = Product.order(:title)
      @products = Product.paginate(page: params[:page], per_page: 5)
    end
  end
end
