require 'test_helper'

class MembershipsControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get approve" do
    get :approve
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

end
