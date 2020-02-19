require 'test_helper'

class Admin::JoboperationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_joboperations_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_joboperations_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_joboperations_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_joboperations_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_joboperations_update_url
    assert_response :success
  end

  test "should get delete" do
    get admin_joboperations_delete_url
    assert_response :success
  end

end
