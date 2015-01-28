class PaymentsController < ApplicationController
  def create
    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card  => params[:stripeToken]
    )

    amount = cart_total(cart_hash)
    payment = Payment.create(user: current_user, amount: amount,
      payment_status_id: PaymentStatus::PROCESSING)

    Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => (amount * 100).round,
      :description => "Rails Stripe customer",
      :currency    => "usd"
    )

    flash[:success] = "Successfully completed payment with amount #{amount}"
    clear_cart
    payment.update_attributes(payment_status_id: PaymentStatus::SUCCESS)
    redirect_to cart_path
  rescue Exception => e
    payment.update_attributes(payment_status_id: PaymentStatus::FAIL)
    flash[:error] = "Payment fails because #{e.message}"
    redirect_to cart_path
  end
end
