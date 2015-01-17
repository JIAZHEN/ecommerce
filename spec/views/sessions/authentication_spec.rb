require "rails_helper"

describe "Login", :type => :view do

  subject { page }

  let(:user)      { create(:user) }
  let(:email)     { user.email }
  let(:password)  { user.password }
  before do
    visit login_path
    fill_in   "Email",    with: email
    fill_in   "Password", with: password
    click_button  "Login"
  end

  describe "with correct details" do
    it { is_expected.to have_link("Logout") }
  end

  describe "with incorrect password" do
    let(:password) { "incorrect" }
    it { is_expected.to have_content("Invalid email/password combination") }
  end

  describe "then logout" do
    before { click_on "Logout" }
    it { is_expected.to have_link("Login") }
  end

  describe "then visit login again" do
    before { visit login_path }
    it { is_expected.not_to have_css(".main_top") }
  end
end
