require 'rails_helper'


RSpec.describe SessionsHelper, :type => :helper do
  let(:user) { create(:user) }

  describe "#log_in" do
    before { log_in user }

    it "records user ID to session" do
      expect(session[:user_id]).to eq(user.id)
    end
  end

  describe "#remember" do
    let(:token) { "TOKEN" }
    before do
      allow(User).to receive(:new_token).and_return(token)
      remember user
    end

    it "records token and id to cookies" do
      expect(cookies[:user_id]).not_to be_nil
      expect(cookies[:remember_token]).to eq(token)
    end
  end

  describe "#forget" do
    let(:token) { "TOKEN" }
    before do
      allow(User).to receive(:new_token).and_return(token)
      remember user
      forget user
    end

    it "doesn't record the user id and token in the cookies" do
      expect(cookies[:user_id]).to be_nil
      expect(cookies[:remember_token]).to be_nil
    end
  end

  describe "#current_user" do
    context "when user doesn't in session and cookies" do
      it "returns nil" do
        expect(current_user).to be_nil
      end
    end

    context "when user is remembered by session" do
      before { log_in user }

      it "returns the correct user" do
        expect(current_user).to eq(user)
      end
    end

    context "when user is remembered by cookies" do
      before { remember user }

      it "returns the correct user and logs in" do
        expect(current_user).to eq(user)
        expect(session[:user_id]).to eq(user.id)
      end
    end
  end
end
