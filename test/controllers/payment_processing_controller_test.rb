require 'test_helper'

class PaymentProcessingControllerTest < ActionDispatch::IntegrationTest
  test "should get make_payment" do
    get payment_processing_make_payment_url
    assert_response :success
  end

  test "should get record_payment" do
    get payment_processing_record_payment_url
    assert_response :success
  end

  test "should get view_payment" do
    get payment_processing_view_payment_url
    assert_response :success
  end

end
