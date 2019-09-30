require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do
  describe "GET /users_logins" do
    it "works! (now write some real specs)" do
       get login_path
       post login_path, params: { session: { email: "", password: "" } }

       expect(response).to have_http_status(200)
       get root_path
  #   expect   
    end
  end
end
