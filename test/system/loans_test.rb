require "application_system_test_case"

class LoansTest < ApplicationSystemTestCase
  setup do
    @loan = loans(:one)
  end

  test "visiting the index" do
    visit loans_url
    assert_selector "h1", text: "Loans"
  end

  test "creating a Loan" do
    visit loans_url
    click_on "New Loan"

    fill_in "Amount borrowed", with: @loan.amount_borrowed
    fill_in "Balance", with: @loan.balance
    fill_in "Loan date", with: @loan.loan_date
    fill_in "Loan type", with: @loan.loan_type_id
    fill_in "Moneylender", with: @loan.moneylender_id
    fill_in "Next amount payment", with: @loan.next_amount_payment
    fill_in "Next payment date", with: @loan.next_payment_date
    fill_in "Start date", with: @loan.start_date
    fill_in "Status", with: @loan.status_id
    click_on "Create Loan"

    assert_text "Loan was successfully created"
    click_on "Back"
  end

  test "updating a Loan" do
    visit loans_url
    click_on "Edit", match: :first

    fill_in "Amount borrowed", with: @loan.amount_borrowed
    fill_in "Balance", with: @loan.balance
    fill_in "Loan date", with: @loan.loan_date
    fill_in "Loan type", with: @loan.loan_type_id
    fill_in "Moneylender", with: @loan.moneylender_id
    fill_in "Next amount payment", with: @loan.next_amount_payment
    fill_in "Next payment date", with: @loan.next_payment_date
    fill_in "Start date", with: @loan.start_date
    fill_in "Status", with: @loan.status_id
    click_on "Update Loan"

    assert_text "Loan was successfully updated"
    click_on "Back"
  end

  test "destroying a Loan" do
    visit loans_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Loan was successfully destroyed"
  end
end
