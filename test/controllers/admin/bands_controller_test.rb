require "test_helper"

class Admin::BandsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_bands_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_bands_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_bands_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_bands_update_url
    assert_response :success
  end
end
