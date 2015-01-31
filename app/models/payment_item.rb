class PaymentItem < ActiveRecord::Base
  belongs_to :payment
  belongs_to :product
end
