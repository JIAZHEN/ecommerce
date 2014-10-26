require 'rails_helper'

describe "Login", :type => :view do

  subject { page }

  let(:user)      { create(:user) }
  let(:email)     { user.email }
  let(:password)  { user.password }
  before do
    visit login_path
    fill_in   "Email",    with: email
    fill_in   "Password", with: password
    click_on  "Login"
  end

  describe "with correct details" do
    it { is_expected.to have_content('create') }
  end

  describe "with incorrect password" do
    let(:password) { "incorrect" }
    it { is_expected.to have_content('Invalid email/password combination') }
  end
end
