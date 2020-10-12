require 'test_helper'

class LoanTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @loan_type = loan_types(:one)
  end

  test "should get index" do
    get loan_types_url
    assert_response :success
  end

  test "should get new" do
    get new_loan_type_url
    assert_response :success
  end

  test "should create loan_type" do
    assert_difference('LoanType.count') do
      post loan_types_url, params: { loan_type: { description: @loan_type.description, is_profit_balane: @loan_type.is_profit_balane, late_fee: @loan_type.late_fee, late_fee_profit: @loan_type.late_fee_profit, number_of_payments: @loan_type.number_of_payments, payment_frequency_days: @loan_type.payment_frequency_days, profit_by_payment: @loan_type.profit_by_payment, short_name: @loan_type.short_name, total_profit: @loan_type.total_profit } }
    end

    assert_redirected_to loan_type_url(LoanType.last)
  end

  test "should show loan_type" do
    get loan_type_url(@loan_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_loan_type_url(@loan_type)
    assert_response :success
  end

  test "should update loan_type" do
    patch loan_type_url(@loan_type), params: { loan_type: { description: @loan_type.description, is_profit_balane: @loan_type.is_profit_balane, late_fee: @loan_type.late_fee, late_fee_profit: @loan_type.late_fee_profit, number_of_payments: @loan_type.number_of_payments, payment_frequency_days: @loan_type.payment_frequency_days, profit_by_payment: @loan_type.profit_by_payment, short_name: @loan_type.short_name, total_profit: @loan_type.total_profit } }
    assert_redirected_to loan_type_url(@loan_type)
  end

  test "should destroy loan_type" do
    assert_difference('LoanType.count', -1) do
      delete loan_type_url(@loan_type)
    end

    assert_redirected_to loan_types_url
  end
end
