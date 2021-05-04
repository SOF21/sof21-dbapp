class Order < ApplicationRecord
  has_many :order_items
  belongs_to :user
  belongs_to :discount_code, optional: true

  ORE_PER_SEK = 100 # Öre per SEK

  def cost_in_ore
    ORE_PER_SEK * cost
  end

  def cost
    cost = order_items.sum { |x| x.cost * x.amount } - rebate - funkis_rebate
    if !discount_code.nil?
      cost -= discount_code.discount
    end
    cost
  end

  def amount
    order_items.sum { |x| x.amount }
  end

  def complete!(id)
    self.payment_method = 'Stripe'
    self.payment_data = id
    # self.receipt_url = stripe_charge.receipt_url
    save_completed_order!
  end

  def complete_free_checkout!
    self.payment_method = 'Gratisköp'
    self.payment_data = 'Gratisköp'
    save_completed_order!
  end

  def has_owner?(owner)
    user == owner
  end

  def purchasable?
    accepted_items = []
    order_items.each do |item|
      if item.purchasable?(accepted_items)
        accepted_items.push item
      end
    end

    accepted_items.length == order_items.length
  end

  def update_funkis_rebate
    self.funkis_rebate = 0
    self.funkis_rebate = [cost, user.rebate_balance].min
  end

  def save_completed_order!
    user.rebate_balance -= funkis_rebate
    user.save!
    save!


    send_receipt
  end

  def send_receipt
    ReceiptMailer.order_receipt(self).deliver_now
    self.receipt_sent = true
    save!
  end
end
