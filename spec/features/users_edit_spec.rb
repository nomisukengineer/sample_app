require 'rails_helper'

RSpec.feature "Edit", type: :feature do
  user = { name: "Naohiro",
            email: "naohiro.nomi@gmail.com",
            password: "Nao-volley51"}

  # ユーザーは編集に成功する
  scenario "successful edit" do
    visit user_path(user)   # 順序を入れ替えただけ
    valid_login(user)       # 順序を入れ替えただけ
  end
end
