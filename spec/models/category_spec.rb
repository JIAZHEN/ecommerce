require 'rails_helper'

RSpec.describe Category, :type => :model do
  let(:category) { Category.new(name: "category_one") }
  subject { category }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:parent_id) }
  it { is_expected.to respond_to(:lft) }
  it { is_expected.to respond_to(:rgt) }
  it { is_expected.to respond_to(:products) }

  describe "#name" do
    context "is not present" do
      before { category.name = " " }
      it { is_expected.not_to be_valid }
    end
  end

  describe "#descendants" do
    context "without any sub categories" do
      let(:category) { create(:category) }
      it "returns empty collection" do
        expect(category.descendants).to be_empty
      end
    end

    context "with sub categories" do
      let(:category) { create(:categ_with_descendants) }
      it "returns all sub categories" do
        expect(category.descendants).to match_array(Category.where(parent_id: category.id))
      end
    end
  end

  describe "#parent" do
    context "without any super category" do
      let(:category) { create(:category) }
      it "returns nil" do
        expect(category.parent).to be_nil
      end
    end

    context "with a super category" do
      let(:category) { create(:categ_with_parent) }

      it "returns parent category" do
        expect(category.parent).to eq(Category.find_by(id: category.parent_id))
      end
    end
  end

  describe "#products" do
    let(:category) { create(:categ_with_products) }
    it "returns all associate products" do
      expect(category.products).to match_array(Product.where(category_id: category.id))
    end
  end
end
