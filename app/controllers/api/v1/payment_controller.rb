class API::V1::PaymentController < ApplicationController
  include ViewPermissionConcern

  before_action :authenticate_user!

  def charge
    order = current_user.cart.create_order
    if order.purchasable?
      if order.amount == 0
        order.complete_free_checkout!
      else
        created_charge = create_charge!(order)
        order.complete! created_charge
      end
      current_user.cart.empty!

      redirect_to api_v1_order_url(order)
    else
      head :not_acceptable
    end
  rescue Stripe::CardError => e
    raise e.message
  end

  private

  def create_charge!(order)
    customer = Stripe::Customer.create(
        :email => current_user.email,
        :source => params[:stripe_token],
    )

    Stripe::Charge.create(
        :customer => customer.id,
        :amount => order.amount_in_ore,
        :description => 'Köp på www.sof17.se',
        :currency => 'sek',
    )
  end
end
