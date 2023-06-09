require "test_helper"

class Customer::CartsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get customer_carts_index_url
    assert_response :success
  end
end
