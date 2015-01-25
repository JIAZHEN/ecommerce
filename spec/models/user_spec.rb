require 'rails_helper'

describe User, :type => :model do
  let(:name)  { "Example User" }
  let(:email) { "user@example.com" }
  let(:password) { "password" }
  let(:password_confirmation) { "password" }
  let(:user)  { User.new(name: name, email: email, password: password, password_confirmation: password_confirmation) }
  subject { user }

  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:password) }
  it { is_expected.to respond_to(:password_digest) }
  it { is_expected.to respond_to(:password_confirmation) }
  it { is_expected.to respond_to(:remember_digest) }
  it { is_expected.to respond_to(:forget) }
  it { is_expected.to respond_to(:cart_count) }

  describe "#email" do
    context "is not present" do
      let(:email) { nil }
      it { is_expected.not_to be_valid }
    end

    [
      "user@example,com", "user_at_foo.org", "user.name@example.",
      "foo@bar_baz.com", "foo@bar+baz.com"
    ].each do |invalid_address|
      context "is in wrong format as #{invalid_address}" do
        let(:email) { invalid_address }
        it { is_expected.not_to be_valid }
      end
    end

    context "is used" do
      before { @duplicate_user = user.dup }
      it "should not be valid" do
        user.save
        expect(@duplicate_user).not_to be_valid
      end

      it "should not be valid when it's upcase" do
        user.email = user.email.upcase
        user.save
        expect(@duplicate_user).not_to be_valid
      end
    end
  end

  describe "#name" do
    context "is not present" do
      let(:name) { nil }
      it { is_expected.not_to be_valid }
    end

    context "is too long" do
      let(:name) { "a" * 60 }
      it { is_expected.not_to be_valid }
    end
  end

  describe "#password" do
    context "is less than minimum" do
      it "should not be valid" do
        user.password = user.password_confirmation = "a" * 5
        expect(user).not_to be_valid
      end
    end
  end

  describe "#authenticate" do
    context "with correct password" do
      before { user.save }
      it "should return the user" do
        found_member = User.find_by(email: email)
        expect(user).to eq(found_member.authenticate(password))
      end
    end
  end

  describe "#remember" do
    let(:new_token) { "NEW_TOKEN" }
    before do
      allow(described_class).to receive(:new_token).and_return(new_token)
      user.save
      user.remember
    end

    it "updates the token" do
      expect(User.find(user.id).remember_digest).to eq(new_token)
    end

    describe "then forget the token" do
      before { user.forget }
      it "sets the token to be nil" do
        expect(User.find(user.id).remember_digest).to be_nil
      end
    end
  end
end
