class Payment < ActiveRecord::Base

  belongs_to :user
  has_one :payment_status

end