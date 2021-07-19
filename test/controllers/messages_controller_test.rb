require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  test "should get forward" do
    get :forward
    assert_response :success
  end

end
