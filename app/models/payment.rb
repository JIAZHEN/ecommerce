class Payment < ActiveRecord::Base

  belongs_to :user
  has_one :status, class_name: "PaymentStatus", foreign_key: "id"

end
