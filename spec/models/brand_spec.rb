require 'rails_helper'

RSpec.describe Brand, :type => :model do
  let(:brand) { Brand.new(name: "brand_one") }
  subject { brand }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:products) }

  describe "#name" do
    context "is not present" do
      before { brand.name = " " }
      it { is_expected.not_to be_valid }
    end
  end
end
