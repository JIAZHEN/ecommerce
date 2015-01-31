class PaymentsController < ApplicationController
  def create
    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card  => params[:stripeToken]
    )
    carts = cart_hash
    products ||= Product.find(carts.keys)
    amount = cart_total(carts, products)

    payment = Payment.create(user: current_user, amount: amount,
      payment_status_id: PaymentStatus::PROCESSING)
    record_items(payment, products, carts)

    Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => (amount * 100).round,
      :description => "Rails Stripe customer",
      :currency    => "gbp"
    )

    flash[:success] = "Successfully completed payment with amount #{amount}"
    payment.update_attributes(payment_status_id: PaymentStatus::SUCCESS)
    clear_cart
    redirect_to cart_path
  rescue Exception => e
    payment.update_attributes(payment_status_id: PaymentStatus::FAIL)
    flash[:error] = "Payment fails because #{e.message}"
    redirect_to cart_path
  end

  private

  def record_items(payment, products, carts)
    products.each do |product|
      price, qty = product.price, carts[product.id]
      PaymentItem.create(payment: payment, product: product,
        qty: qty, price: product.price, total: price * qty)
    end
  end
end
