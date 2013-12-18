require 'test_helper'

class AboutControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get presenters" do
    get :presenters
    assert_response :success
  end

  test "should get organizers" do
    get :organizers
    assert_response :success
  end

end
