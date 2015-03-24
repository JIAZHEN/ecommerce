class PaymentsController < ApplicationController
  def create
    carts = cart_hash
    products ||= Product.find(carts.keys)
    qty_errors = insufficient_items(carts, products).inject([]) do |errors, product|
      errors << "#{product.name} has only #{product.qty} #{'unit'.pluralize(product.qty)} left\n"
    end

    if qty_errors
      flash[:error] = qty_errors
      return redirect_to cart_path
    end

    amount = cart_total(carts, products)

    payment = Payment.create(user: current_user, amount: amount,
      payment_status_id: PaymentStatus::PROCESSING)
    record_items(payment, products, carts)

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card  => params[:stripeToken]
    )
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

  def insufficient_items(carts, products)
    products.select { |product| product.qty < carts[product.id] }
  end
end
