require 'rails_helper'

RSpec.describe Product, :type => :model do
  let(:name) { "sample product" }
  let(:price) { 9.99 }
  let(:brand_id) { 3 }
  let(:category_id) { 3 }
  let(:description) { "sample desc" }
  let(:description_markup) { "desc markup" }
  let(:product_type_id) { 3 }
  let(:product) { Product.new(name: name, price: price, brand_id: brand_id,
                              category_id: category_id, description: description,
                              description_markup: description_markup, product_type_id: product_type_id)
                }
  subject { product }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:price) }
  it { is_expected.to respond_to(:brand_id) }
  it { is_expected.to respond_to(:category_id) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:description_markup) }
  it { is_expected.to respond_to(:product_type_id) }

  describe "#name" do
    context "is not present" do
      let(:name) { "" }
      it { is_expected.not_to be_valid }
    end

    context "is less than six" do
      let(:name) { "a" * 5 }
      it { is_expected.not_to be_valid }
    end
  end

  describe "#price" do
    context "is not number" do
      let(:price) { "a" }
      it { is_expected.not_to be_valid }
    end
  end

end
