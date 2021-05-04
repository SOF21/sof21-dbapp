class API::V1::PaymentController < ApplicationController
  include ViewPermissionConcern

  before_action :authenticate_user!

  def charge
    order = current_user.cart.create_order
    if !current_user.cart.cart_items.empty? && order.purchasable?
      if order.cost == 0
        order.complete_free_checkout!
      else
        order.complete!(params[:stripe_id])
      end
      current_user.cart.clear!
      render :status => 200, :json => "Successfully completed order"
    else
      render :status => 406, :json => "Empty cart or items that can't be purchased"
    end
  rescue Stripe::CardError => e
    render :status => 400, :json => e.json_body[:error][:message]
  rescue Stripe::RateLimitError => e
    render :status => 400, :json => e.json_body[:error][:message]
  rescue Stripe::InvalidRequestError => e
    render :status => 400, :json => e.json_body[:error][:message]
  rescue Stripe::AuthenticationError => e
    render :status => 400, :json => e.json_body[:error][:message]
  rescue Stripe::APIConnectionError => e
    render :status => 400, :json => e.json_body[:error][:message]
  rescue Stripe::StripeError => e
    render :status => 400, :json => e.json_body[:error][:message]

  end

  def get_client_secret 
    order = current_user.cart.create_order
    if !current_user.cart.cart_items.empty? && order.purchasable?
      if order.cost != 0
        intent = create_charge!(order)
        print intent
        render :json => intent[:client_secret].to_json
      end
    end
  end 


  private

  def create_charge!(order)
    customer = Stripe::Customer.create(
        :email => current_user.email,
    )

    products = ""
    order.order_items.each do |item|
      prod = Product.find_by(id: item.product_id)
      base_prod = BaseProduct.find_by(id: prod.base_product_id)
       # Some products have no name, add base_product name just in case
       unless prod.kind.nil?
         products += "" + item.amount.to_s + "x " + base_prod.name + "(" + prod.kind + ")" + "\n"
       else
         products += "" + item.amount.to_s + "x " + base_prod.name + "\n"
      end
    end
    if !order.discount_code.nil?
      products += "rabattkod(" + order.discount_code.code + ")" "\n"
    end

    Stripe::PaymentIntent.create(
        :customer => customer.id,
        :amount => order.cost_in_ore,
        :description => products,
        :currency => 'sek',
        :receipt_email => current_user.email,
        metadata: {integration_check: 'accept_a_payment'},
    )
  end
end
