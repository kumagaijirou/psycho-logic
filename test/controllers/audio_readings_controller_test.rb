require "test_helper"

class AudioReadingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get audio_readings_index_url
    assert_response :success
  end

  test "should get show" do
    get audio_readings_show_url
    assert_response :success
  end

  test "should get new" do
    get audio_readings_new_url
    assert_response :success
  end

  test "should get create" do
    get audio_readings_create_url
    assert_response :success
  end

  test "should get edit" do
    get audio_readings_edit_url
    assert_response :success
  end

  test "should get update" do
    get audio_readings_update_url
    assert_response :success
  end

  test "should get destroy" do
    get audio_readings_destroy_url
    assert_response :success
  end
end
