require 'test_helper'

class Admin::RepairoptionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_repairoptions_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_repairoptions_create_url
    assert_response :success
  end

  test "should get update" do
    get admin_repairoptions_update_url
    assert_response :success
  end

  test "should get edit" do
    get admin_repairoptions_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_repairoptions_destroy_url
    assert_response :success
  end

  test "should get index" do
    get admin_repairoptions_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_repairoptions_show_url
    assert_response :success
  end

end
