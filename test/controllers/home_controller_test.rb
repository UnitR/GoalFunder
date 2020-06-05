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

  test "should get about" do
    get home_about_url
    assert_response :success
  end

  test "should post request contact but no email" do
    post request_contact_url

    assert_response :redirect
    assert_not_empty flash[:alert]
    assert_nil flash[:notice]
  end

  test "should post request contact" do
    post request_contact_url, params:
    {name: "Name", email: "name@email.com", telephone: "1234567890", message: "Hello"}
    assert_response :redirect
    assert_nil flash[:alert]
    assert_not_empty flash[:notice]
  end

end
