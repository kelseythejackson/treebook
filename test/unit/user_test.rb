require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:user_friendships)
  should have_many(:friends)


  test "a user should enter a first name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:first_name].empty?
  end

  test "a user should enter a last name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:last_name].empty?
  end

  test "a user should enter a profile name" do
  	user = User.new
  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  end

  test "a user should have a unique profile name" do
  	user = User.new
  	user.profile_name = users(:kelsey).profile_name
  	users(:kelsey)
  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  end

  test "a user sjould have a profile name without spaces" do
  	user = User.new(first_name: 'Kelsey', last_name: 'Jackson', email: 'kelsey3@artfulgiant.com' )
    user.password = user.password_confirmation = 'asdfasdf'
    
  	user.profile_name = "My Profile With Spaces"

  	assert !user.save
  	assert !user.errors[:profile_name].empty?
  	assert user.errors[:profile_name].include?("Must be formatted correctly.")
  end

  test "a user can hava a correctly formatted profile name" do
    user = User.new(first_name: 'Kelsey', last_name: 'Jackson', email: 'kelsey3@artfulgiant.com' )
    user.password = user.password_confirmation = 'asdfasdf'

    user.profile_name = 'kelseyjackson_1'
    assert user.valid?
  end

  test "that no error is raised when trying to access a friend list" do
    assert_nothing_raised do
      users(:kelsey).friends
    end
  end

  test "that creating friendships on a user works" do
    users(:kelsey).friends << users(:mike)
    users(:kelsey).friends.reload
    assert users(:kelsey).friends.include?(users(:mike))
  end
end
