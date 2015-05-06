module CurrentCart
  extend ActiveSupport::Concern
  
  private
  
  def set_cart
    @cart = Cart.find(session[:cart_id])
    @carts_line_items = LineItem.where(cart: @cart).paginate(page: params[:cart_page], per_page: 3)
    rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end
end