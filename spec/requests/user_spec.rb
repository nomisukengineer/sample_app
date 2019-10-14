require 'rails_helper'


RSpec.describe "User pages", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  # 他のアクションのテストは省略

  describe "#create" do
    include ActiveJob::TestHelper

    it "is invalid with invalid signup information" do
      perform_enqueued_jobs do
        expect {
          post users_path, params: { user: { name: "",
                                            email: "user@invalid",
                                            password: "foo",
                                            password_confirmation: "bar" } }
        }.to_not change(User, :count)
      end
    end

    it "is valid with valid signup information" do
      perform_enqueued_jobs do
        expect {
          post users_path, params: { user: { name: "ExampleUser",
                                            email: "user@example.com",
                                            password: "password",
                                            password_confirmation: "password" } }
        }.to change(User, :count).by(1)

        expect(response).to redirect_to root_path
        user = assigns(:user)    # gem 'rails-controller-testing'をインストール
        # 有効化していない状態でログインしてみる
        #sign_in_as(user)
        expect(session[:user_id]).to be_falsey
        # 有効化トークンが不正な場合
        get edit_account_activation_path("invalid token", email: user.email)
        expect(session[:user_id]).to be_falsey
        # トークンは正しいがメールアドレスが無効な場合
        get edit_account_activation_path(user.activation_token, email: 'wrong')
        expect(session[:user_id]).to be_falsey
        # 有効化トークンが正しい場合
        get edit_account_activation_path(user.activation_token, email: user.email)
        expect(session[:user_id]).to eq user.id
        expect(user.name).to eq "ExampleUser"
        expect(user.email).to eq "user@example.com"
        expect(user.password).to eq "password"
      end
    end
  end
end

RSpec.describe "Home page", type: :request do
  # 正常なレスポンスを返すこと
  it "responds successfully" do
      get root_path
      expect(response).to be_success
      expect(response).to have_http_status "200"
  end
end

RSpec.describe "Index page", type: :request do
  # 正常なレスポンスを返すこと
  it "responds successfully" do
      get users_path
      expect(response).not_to be_success
      expect(response).to have_http_status "302"
  end
end

RSpec.describe "New page", type: :request do
  # 正常なレスポンスを返すこと
  it "responds successfully" do
      get new_user_path
      expect(response).to be_success
      expect(response).to have_http_status "200"
  end
end


RSpec.describe "User pages2", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  # 他のアクションのテストは省略

  describe "#show" do
    include ActiveJob::TestHelper

    it "is invalid with invalid signup information" do
      perform_enqueued_jobs do
        expect {
          post users_path, params: { user: { name: "",
                                            email: "user@invalid",
                                            password: "foo",
                                            password_confirmation: "bar" } }
        }.to_not change(User, :count)
      end
    end

    it "is valid with valid signup information" do
      perform_enqueued_jobs do
        expect {
          post users_path, params: { user: { name: "ExampleUser",
                                            email: "user@example.com",
                                            password: "password",
                                            password_confirmation: "password" } }
        }.to change(User, :count).by(1)

        expect(response).to redirect_to root_path
        user = assigns(:user)    # gem 'rails-controller-testing'をインストール
        # 有効化していない状態でログインしてみる
        #sign_in_as(user)
        expect(session[:user_id]).to be_falsey
        # 有効化トークンが不正な場合
        get edit_account_activation_path("invalid token", email: user.email)
        expect(session[:user_id]).to be_falsey
        # トークンは正しいがメールアドレスが無効な場合
        get edit_account_activation_path(user.activation_token, email: 'wrong')
        expect(session[:user_id]).to be_falsey
        # 有効化トークンが正しい場合
        get edit_account_activation_path(user.activation_token, email: user.email)
        expect(session[:user_id]).to eq user.id
        expect(user.name).to eq "ExampleUser"
        expect(user.email).to eq "user@example.com"
        expect(user.password).to eq "password"
      end
    end
  end
end


RSpec.describe "User pages3", type: :request do
#  user = User.create(user: {
#    name: "nomisuke"} )
#  let(:other_user) { FactoryBot.create(user: {
#    name: "takeshi"} ) }

  # 他のアクションのテストは省略

  describe "#delete" do
    include ActiveJob::TestHelper

    it "is invalid with invalid signup information" do
      perform_enqueued_jobs do
        expect {
          get users_path, params: { user: { name: "",
                                            email: "user@invalid",
                                            password: "foo",
                                            password_confirmation: "bar" } }
        }.to_not change(User, :count)
      end
    end

    it "is valid with valid signup information" do
      perform_enqueued_jobs do
        expect {
          post users_path, params: { user: { name: "ExampleUser",
                                            email: "user@example.com",
                                            password: "password",
                                            password_confirmation: "password" } }
        }.to change(User, :count).by(1)

        expect(response).to redirect_to root_path
        user = assigns(:user)    # gem 'rails-controller-testing'をインストール
        # 有効化していない状態でログインしてみる
        #sign_in_as(user)
        expect(session[:user_id]).to be_falsey
        # 有効化トークンが不正な場合
        get edit_account_activation_path("invalid token", email: user.email)
        expect(session[:user_id]).to be_falsey
        # トークンは正しいがメールアドレスが無効な場合
        get edit_account_activation_path(user.activation_token, email: 'wrong')
        expect(session[:user_id]).to be_falsey
        # 有効化トークンが正しい場合
        get edit_account_activation_path(user.activation_token, email: user.email)
        expect(session[:user_id]).to eq user.id
        expect(user.name).to eq "ExampleUser"
        expect(user.email).to eq "user@example.com"
        expect(user.password).to eq "password"
      end
    end
  end
end

=begin
  describe "#destroy" do
    # 認可されたユーザーとして
    context "as an authorized user" do
      # ユーザーを削除できること
      it "deletes a user" do
        sign_in_as user
        expect {
          delete user_path(user), params: { id: user.id }
        }.to change(User, :count).by(-1)
      end
    end

    # アカウントの違うユーザーの場合
    context "as au unauthorized user" do
      # ホーム画面にリダイレクトすること
      it "redirects to the dashboard" do
        #sign_in_as other_user
        #delete user_path(user), params: { id: user.id }
        expect(response).to redirect_to root_path
      end
    end

    # ゲストとして
    context "as a guest" do
      it "returns a 302 response" do
        delete user_path(user), params: { id: user.id }
        expect(response).to have_http_status "302"
      end

      it "redirects to the sign-in page" do
        delete user_path(user), params: { user: { name: "validuser",
                                                  email: "user@valid.com",
                                                  password: "foobar",
                                                  password_confirmation: "foobar" } }
        expect(response).to redirect_to login_path
      end
    end
  end

=end



