require 'test_helper'

class LoansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @loan = loans(:one)
  end

  test "should get index" do
    get loans_url
    assert_response :success
  end

  test "should get new" do
    get new_loan_url
    assert_response :success
  end

  test "should create loan" do
    assert_difference('Loan.count') do
      post loans_url, params: { loan: { amount_borrowed: @loan.amount_borrowed, balance: @loan.balance, loan_date: @loan.loan_date, loan_type_id: @loan.loan_type_id, moneylender_id: @loan.moneylender_id, next_amount_payment: @loan.next_amount_payment, next_payment_date: @loan.next_payment_date, start_date: @loan.start_date, status_id: @loan.status_id } }
    end

    assert_redirected_to loan_url(Loan.last)
  end

  test "should show loan" do
    get loan_url(@loan)
    assert_response :success
  end

  test "should get edit" do
    get edit_loan_url(@loan)
    assert_response :success
  end

  test "should update loan" do
    patch loan_url(@loan), params: { loan: { amount_borrowed: @loan.amount_borrowed, balance: @loan.balance, loan_date: @loan.loan_date, loan_type_id: @loan.loan_type_id, moneylender_id: @loan.moneylender_id, next_amount_payment: @loan.next_amount_payment, next_payment_date: @loan.next_payment_date, start_date: @loan.start_date, status_id: @loan.status_id } }
    assert_redirected_to loan_url(@loan)
  end

  test "should destroy loan" do
    assert_difference('Loan.count', -1) do
      delete loan_url(@loan)
    end

    assert_redirected_to loans_url
  end
end
