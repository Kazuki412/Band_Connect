require "test_helper"

class Admin::MotivationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_motivations_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_motivations_edit_url
    assert_response :success
  end
end
