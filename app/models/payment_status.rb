class PaymentStatus < ActiveRecord::Base
  SUCCESS = 1
  FAIL = 2
  ERROR = 3
  PROCESSING = 4
end
