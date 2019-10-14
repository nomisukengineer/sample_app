require 'rails_helper'

RSpec.describe Micropost, type: :model do

  def setup
    @user = users(
      name: "michael",
      id: 2)
    # このコードは慣習的に正しくない
    @micropost = Micropost.new(
      content: "Lorem ipsum",
      user_id: @user.id
    )
  end

  #use_idが存在しているかどうか
  it "user id is present" do
    @micropost = Micropost.new(content: "Lorem ipsum", user_id: nil)
    expect(@micropost).not_to be_valid
  end

  #何か文字が書かれていれば有効であること
  it "content is present" do
    @micropost = Micropost.new(
      content: " ",
      user_id: 2
    )
    expect(@micropost).not_to be_valid
  end

  #141文字以上の投稿は有効でない
  it "is at most 140 characters" do
    @micropost = Micropost.new(
      content: "a"*141,
      user_id: 2
    )
    expect(@micropost).not_to be_valid
  end

end
