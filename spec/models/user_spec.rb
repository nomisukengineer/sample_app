require 'rails_helper'

RSpec.describe User, type: :model do

  #姓、名、メール、パスワードがあれば有効な状態であること
  it "is valid with a first name, last name, email, and password" do
    user = User.new(
      name: "nomisuke",
      email: "nomi@gmail.com",
      password: "password",
    )
    expect(user).to be_valid
  end

  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email address" do
    user = User.new(
      email: nil
    )
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  #メールアドレスが重複している場合登録できないこと
  it "is invalid with a duplicate email address" do
    User.create(
      name: "nomisuke",
      email: "nomi@gmail.com",
      password: "password",
    )

    user = User.new(
      name: "nomitakeshi",
      email: "nomi@gmail.com",
      password: "password",
    )
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "メールアドレスが重複していたら登録できない" do
    user1 = FactoryBot.create(:user,name: "taro", email: "taro@example.com", password: "tarotaro1")
    expect(FactoryBot.build(:user, name: "ziro", email: user1.email, password: "ziroziro1")).to_not be_valid
  end


end



  # メールアドレスの有効性
  describe "email validation should reject invalid addresses" do
    # 無効なメールアドレスの場合
    it "should be invalid" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                          foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      user = User.new(email: invalid_address)
      expect(user).to_not be_valid
    end
  end

    # 有効なメールアドレスの場合
    it "should be valid" do
      valid_addresses = %w[user@foo.com A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      valid_addresses.each do |valid_address|
        user = User.new(
          name: "nomisuke",
          email: valid_address,
          password: "password",
          )
        expect(user).to be_valid
      end
    end
  end

  # パスワード確認が一致すること
  describe "when password doesn't match confirmation" do
    # 一致する場合
    it "is valid when password confirmation matches password" do
      user = User.new(
        name: "nomisuke",
        email: "nomi@gmail.com",
        password: "password",
        password_confirmation: "password")
      expect(user).to be_valid
    end
  
    # 一致しない場合
    it "is invalid when password confirmation doesn't match password" do
      user = User.new(
        name: "nomisuke",
        email: "nomi@gmail.com",
        password: "password",
        password_confirmation: "different")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end

  #パスワードが短すぎる場合無効になること
  describe "when password is too short" do
    it "is invalid when password is too short" do
      user = User.new(
      name: "nomisuke",
      email: "nomi@gmail.com",
      password: "no",
      password_confirmation: "no")
    user.valid?
    expect(user).not_to be_valid
    end
    it "is valid when password is 6 characters" do
      user = User.new(
        name: "nomisuke",
        email: "nomi@gmail.com",
        password: "nomisu",
        password_confirmation: "nomisu")
      user.valid?
      expect(user).to be_valid
    end
  end


