require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get home_index_url
    assert_response :success
  end

  test "should get contact" do
    get home_contact_url
    assert_response :success
  end

  test "should get sign_up" do
    get home_sign_up_url
    assert_response :success
  end

  test "should get log_in" do
    get home_log_in_url
    assert_response :success
  end

  test "should get show_fundraisers" do
    get home_show_fundraisers_url
    assert_response :success
  end

  test "should get show_groups" do
    get home_show_groups_url
    assert_response :success
  end

  test "should get show_goals" do
    get home_show_goals_url
    assert_response :success
  end

end
