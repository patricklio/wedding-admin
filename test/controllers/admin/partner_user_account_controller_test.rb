require 'test_helper'

class Admin::PartnerUserAccountControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_partner_user_account_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_partner_user_account_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_partner_user_account_create_url
    assert_response :success
  end

end
