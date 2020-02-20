require 'test_helper'

class Admin::PartnersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_partners_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_partners_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_partners_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_partners_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_partners_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_partners_destroy_url
    assert_response :success
  end

end
