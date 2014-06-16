require 'rails_helper'

describe User do 
  describe ".top_rated" do
    before :each do 
      @user1 = create(:user)
      post = create(:post, user: @user1)
      create(:comment, user: @user1, post: post)

      @user2 = create(:user)
      post = create(:post, user: @user2)
      2.times { create(:comment, user: @user2, post: post) }
    end

    it "should return users based on comments + posts" do
      expect( User.top_rated ).to eq([@user2, @user1])
    end

    it "should have `comments_count` on user" do
      users = User.top_rated
      expect( users.first.comments_count ).to eq(2)
    end
  end
end