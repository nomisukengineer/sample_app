require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do
    describe "POST #create" do
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
                post :create
                expect(response).to have_http_status(302)
            end

            #302レスポンスのあと、loginページに遷移すること
            it "redirects to the login page" do
                post :create
                expect(response).to redirect_to "/login"
            end
        end
    end
end
