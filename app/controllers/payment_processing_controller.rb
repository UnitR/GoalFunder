require 'paypal_client'

class PaymentProcessingController < ApplicationController
  include PayPalClient

  # Verify request parameters
  before_action :set_payment, except: :make_payment

  def make_payment

    # Set up payment object
    @payment = Payment.new(payment_params)

    # Perform payment request with PayPal
    do_request()

    # Handle the different scenarios of payment
    # If failed due to payment method being rejected, retry again
    # If failed for any other reason, return error response
    if @response && @response.result.status == "CREATED" then

      @payment.pp_id = response.result.id

      # Save the membership
      respond_to do |format|
        if @payment.save then
          format.html { redirect_to payment_processing_view_payment_path, notice:
              "Successfully contributed to goal '#{Goals.find(@payment.goal_id).name}'!" }
          format.json { render :show, status: :ok, location: @payment }
        else
          format.html { render :show }
          format.json { render json: @payment.errors, status: :unprocessable_entity }
        end
      end

    elsif @response && @response.result.status = 'INSTRUMENT_DECLINED'

      # Retry until payment method not refused
      is_refused = true
      while is_refused

        # TODO: can this get stuck in an infinite loop?
        if do_request() && @response.result.stats = 'INSTRUMENT_DECLINED'
          is_refused = true
        else
          is_refused = false
        end

      end

    else

      # Show error
      # Should not really happen with the current code
      respond_to do |format|
        format.html { render :"goals/show/#{@payment.goal_id}", notice: 'Could not process payment with PayPal.'}
        format.json { render json: "Could not process payment with PayPal.\r\n#{response.result}", status: :unprocessable_entity }

        # Log in server console for now
        puts @response_err.status_code
      end

    end

  end

  def view_payment
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_payment
    @payment = Payment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def payment_params
    params.require(:payment).permit(:user_id, :goal_id, :amount, :pp_id)
  end

  # Ensures the user is the owner of a group
  def check_payment

    # Check if user ID matches group owner's ID
    raise User::NotAuthorized unless current_user.id = @payment.user_id

  end

  def do_request

    # Create request with the specified parameters
    request = PayPalCheckoutSdk::Orders::OrdersCreateRequest::new
    request.request_body({
                             intent: "CAPTURE",
                             purchase_units: [
                                 {
                                     amount: {
                                         currency_code: "GBP",
                                         value: @payment.amount.to_s
                                     }
                                 }
                             ]
                         })

    begin

      # Perform the specified request from above
      @response = PayPalClient.client.execute(request)
      return true

    rescue => e
      @request_err = e
      return false

    end

  end

end
