require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:friend)

  test "that creating a friendshipworks without raising an exception" do
  	assert_nothing_raised do
  		UserFriendship.create user: users(:kelsey), friend: users(:mike)
  	end
  end

  test "that creating a friendship based on user id and friend id works" do
  	UserFriendship.create user_id: users(:kelsey).id, friend_id: users(:mike).id
  	assert users(:kelsey).friends.include?(users(:mike))
  end
end
