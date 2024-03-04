require "test_helper"

class Public::BandsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_bands_new_url
    assert_response :success
  end

  test "should get create" do
    get public_bands_create_url
    assert_response :success
  end

  test "should get index" do
    get public_bands_index_url
    assert_response :success
  end

  test "should get show" do
    get public_bands_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_bands_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_bands_update_url
    assert_response :success
  end

  test "should get destroy" do
    get public_bands_destroy_url
    assert_response :success
  end
end
