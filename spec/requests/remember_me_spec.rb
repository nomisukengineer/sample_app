require 'rails_helper'



RSpec.describe "User pages", type: :request do
  #let(:user) { FactoryBot.create(:user) }
  user = {name: 'nomisuke',
          email: "nomi.naohiro1@gmail.com",
          password: 'Nao-volley51',
          password_confirmation: "Nao-volley51" }
  #let(:other_user) { FactoryBot.create(:user) }

  # 2つのバグのテスト1
  context "with valid information" do
    # ログイン中のみログアウトすること
    it "logs in with valid information followed by logout" do
    #  sign_in_as(user)     # spec/support/utilities.rbに定義
    #  expect(response).to redirect_to logout_path #(user)

      # ログアウトする
      delete logout_path
      expect(response).to redirect_to root_path
      expect(session[:user_id]).to eq nil

      # 2番目のウィンドウでログアウトする
      delete logout_path
      expect(response).to redirect_to root_path
      expect(session[:user_id]).to eq nil
    end
  end
end