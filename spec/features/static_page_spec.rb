require 'rails_helper'

#RSpec.feature "StaticPages", type: :feature do
#  pending "add some scenarios (or delete) #{__FILE__}"
#endi

describe 'Home' do
  specify 'タイトル内容の表示' do
    visit root_path
    expect(page).to have_css('h1', text: 'Sample App')
    expect(page).to have_title 'Ruby on Rails Tutorial Sample App'
  end
end

describe 'Help' do
  specify 'タイトル内容の表示' do
    visit help_path
    expect(page).to have_css('h1', text: 'Help')
    expect(page).to have_title 'Help | Ruby on Rails Tutorial Sample App'
  end
end

describe 'about' do
  specify 'タイトル内容の表示' do
    visit about_path
    expect(page).to have_css('h1', text: 'About')
    expect(page).to have_title 'About | Ruby on Rails Tutorial Sample App'
  end
end

describe 'Contact' do
  specify 'ページの表示' do
    visit contact_path
    expect(page).to have_css('h1', text: 'Contact')
    expect(page).to have_title 'Contact | Ruby on Rails Tutorial Sample App'
  end
end

describe 'Signup' do
  specify 'ページの表示' do
    visit signup_path
  end
end
