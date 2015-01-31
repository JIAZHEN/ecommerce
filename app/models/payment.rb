class Payment < ActiveRecord::Base

  belongs_to :user
  belongs_to :status, class_name: "PaymentStatus", foreign_key: "payment_status_id"
  has_many :items, class_name: "PaymentItem", foreign_key: "payment_id"

end
