require "test_helper"

class Customer::ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get customer_products_index_url
    assert_response :success
  end
end
