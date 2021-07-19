require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "phone numbers with extra characters should be valid" do
    user = User.new(email: "test@user.com", phone_no: "(123) 456-7890");
    assert user.valid?
  end

  test "phone numbers with more than 10 numbers are invalid" do
    user = User.new(email: "test@user.com", phone_no: "(123) 456-7890123");
    assert_not user.valid?
  end
end
