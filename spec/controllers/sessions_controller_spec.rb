require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

    #200レスポンスを返すこと
      it "returns a 200 response" do
        get :new
        expect(response).to have_http_status(200)
      end

end
