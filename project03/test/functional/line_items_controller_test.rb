require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
  setup do
    @line_item = line_items(:one)
  end

  test "should create line_item" do
    assert_difference('LineItem.count') do
      post :create, product_id: products(:one).id
    end

    assert_redirected_to cart_path
  end

  test "should update line_item" do
    put :update, id: @line_item, line_item: @line_item.attributes
    assert_redirected_to cart_path
  end

  test "should destroy line_item" do
    assert_difference('LineItem.count', -1) do
      delete :destroy, id: @line_item
    end

    assert_redirected_to cart_path
  end
end
