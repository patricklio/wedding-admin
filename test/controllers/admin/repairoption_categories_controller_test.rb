require 'test_helper'

class Admin::RepairoptionCategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_repairoption_categories_index_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_repairoption_categories_destroy_url
    assert_response :success
  end

end
