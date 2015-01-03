require 'rails_helper'

RSpec.describe Category, :type => :model do
  let(:category) { Category.new(name: "category_one") }
  subject { category }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:parent_id) }
  it { is_expected.to respond_to(:subs) }
  it { is_expected.to respond_to(:parent) }

  describe "#name" do
    context "is not present" do
      before { category.name = " " }
      it { is_expected.not_to be_valid }
    end
  end

  describe "#subs" do
    context "without any sub categories" do
      let(:category) { create(:category) }
      it "returns empty collection" do
        expect(category.subs).to be_empty
      end
    end

    context "with sub categories" do
      let(:category) { create(:categ_with_subs) }
      it "returns all sub categories" do
        expect(category.subs).to eq(Category.where(parent_id: category.id))
      end
    end
  end

  describe "#parent" do
    context "without any super category" do
      let(:category) { create(:category) }
      it "returns nil" do
        expect(category.subs).to be_empty
      end
    end

    context "with a super category" do
      let(:category) { create(:categ_with_parent) }

      it "returns parent category" do
        expect(category.parent).to eq(Category.find_by(id: category.parent_id))
      end
    end
  end
end
