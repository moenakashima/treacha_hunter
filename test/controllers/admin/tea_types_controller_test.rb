require "test_helper"

class Admin::TeaTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_tea_types_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_tea_types_edit_url
    assert_response :success
  end
end
