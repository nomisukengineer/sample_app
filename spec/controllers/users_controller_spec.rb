require 'rails_helper'

RSpec.describe UsersController, type: :controller do

    describe "GET #new" do
        it "returns http success" do
            get :new
            expect(response).to have_http_status(:success)
        end

        #200レスポンスを返すこと
        it "returns a 200 response" do
            get :new
            expect(response).to have_http_status(200)
        end
    end

    describe "GET #index" do
        before do
            user = User.new(
                name: "nomisuke",
                email: "nomi@gmail.com",
                password: "password"
            )
        end

        #ゲストユーザー
        context "as a guest" do
            #ログインしていない状態では、302レスポンスを返すこと
            it "returns a 200 response" do
                get :index
                expect(response).to have_http_status(302)
            end

            #302レスポンスのあと、loginページに遷移すること
            it "redirects to the login page" do
                get :index
                expect(response).to redirect_to "/login"
            end
        end
    end
end