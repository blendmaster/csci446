require 'test_helper'

class CartsControllerTest < ActionController::TestCase
  test "should show cart" do
    get :show
    assert_response :success
  end

  test "should empty cart" do
    post :empty
    assert_redirected_to cart_path
  end
end
