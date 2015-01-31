require 'rails_helper'

RSpec.describe Payment, :type => :model do
  let(:payment) do
    described_class.new(user_id: 1, amount: 1.5,
      shipping_cost: 1.5, payment_status_id: 1)
  end

  subject { payment }

  it { is_expected.to respond_to(:user_id) }
  it { is_expected.to respond_to(:amount) }
  it { is_expected.to respond_to(:shipping_cost) }
  it { is_expected.to respond_to(:payment_status_id) }
  it { is_expected.to respond_to(:user) }
  it { is_expected.to respond_to(:status) }
  it { is_expected.to respond_to(:items) }

end
