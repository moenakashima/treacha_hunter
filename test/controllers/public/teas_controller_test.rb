require "test_helper"

class Public::TeasControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_teas_new_url
    assert_response :success
  end

  test "should get index" do
    get public_teas_index_url
    assert_response :success
  end
end
