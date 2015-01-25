require 'rails_helper'

RSpec.describe CartsController, :type => :controller do

  describe "GET new" do
    it "raises UrlGenerationError" do
      expect { get :new }.to raise_error(ActionController::UrlGenerationError)
    end
  end

  describe "GET show" do
    it "redirects to login path" do
      get :show
      expect(response).to redirect_to(login_path)
    end
  end

end
