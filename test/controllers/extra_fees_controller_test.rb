require 'test_helper'

class ExtraFeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @extra_fee = extra_fees(:one)
  end

  test "should get index" do
    get extra_fees_url
    assert_response :success
  end

  test "should get new" do
    get new_extra_fee_url
    assert_response :success
  end

  test "should create extra_fee" do
    assert_difference('ExtraFee.count') do
      post extra_fees_url, params: { extra_fee: { late_fee: @extra_fee.late_fee, late_fee_profit: @extra_fee.late_fee_profit, loan_id: @extra_fee.loan_id, new_balance: @extra_fee.new_balance, old_balance: @extra_fee.old_balance } }
    end

    assert_redirected_to extra_fee_url(ExtraFee.last)
  end

  test "should show extra_fee" do
    get extra_fee_url(@extra_fee)
    assert_response :success
  end

  test "should get edit" do
    get edit_extra_fee_url(@extra_fee)
    assert_response :success
  end

  test "should update extra_fee" do
    patch extra_fee_url(@extra_fee), params: { extra_fee: { late_fee: @extra_fee.late_fee, late_fee_profit: @extra_fee.late_fee_profit, loan_id: @extra_fee.loan_id, new_balance: @extra_fee.new_balance, old_balance: @extra_fee.old_balance } }
    assert_redirected_to extra_fee_url(@extra_fee)
  end

  test "should destroy extra_fee" do
    assert_difference('ExtraFee.count', -1) do
      delete extra_fee_url(@extra_fee)
    end

    assert_redirected_to extra_fees_url
  end
end
