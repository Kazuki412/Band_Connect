require "test_helper"

class MusicalInstrumentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get musical_instruments_index_url
    assert_response :success
  end

  test "should get edit" do
    get musical_instruments_edit_url
    assert_response :success
  end
end
