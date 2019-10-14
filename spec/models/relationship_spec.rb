require 'rails_helper'

RSpec.describe Relationship, type: :model do
  def setup
    users = Users.all
    @relationship = Relationship.new(follower_id: users(:michael).id,
                                     followed_id: users(:archer).id)
  end


  it "requires a follower id" do
    @relationship = Relationship.new(follower_id: 3,
                                      followed_id: nil)
    expect(@relationship).not_to be_valid
  end

  it "followed id" do
    @relationship = Relationship.new(follower_id: nil,
                                      followed_id: 3)
    expect(@relationship).not_to be_valid
  end

end