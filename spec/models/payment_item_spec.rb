require 'rails_helper'

RSpec.describe PaymentItem, :type => :model do
  let(:payment_item) do
    described_class.new(payment_id: 1,
    product_id: 1, price: 1.5,
    qty: 1, total: 1.5)
  end

  subject { payment_item }

  it { is_expected.to respond_to(:payment_id) }
  it { is_expected.to respond_to(:product_id) }
  it { is_expected.to respond_to(:price) }
  it { is_expected.to respond_to(:qty) }
  it { is_expected.to respond_to(:total) }
  it { is_expected.to respond_to(:product) }
  it { is_expected.to respond_to(:payment) }
end
