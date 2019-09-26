require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  before do
    visit login_path
  end

  #無効な値を入力する
  describe 'enter an invalid values' do
    before do
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      click_button 'Log in'
    end
  end
end
