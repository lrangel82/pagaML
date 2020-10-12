require "application_system_test_case"

class LoanTypesTest < ApplicationSystemTestCase
  setup do
    @loan_type = loan_types(:one)
  end

  test "visiting the index" do
    visit loan_types_url
    assert_selector "h1", text: "Loan Types"
  end

  test "creating a Loan type" do
    visit loan_types_url
    click_on "New Loan Type"

    fill_in "Description", with: @loan_type.description
    check "Is profit balane" if @loan_type.is_profit_balane
    fill_in "Late fee", with: @loan_type.late_fee
    fill_in "Late fee profit", with: @loan_type.late_fee_profit
    fill_in "Number of payments", with: @loan_type.number_of_payments
    fill_in "Payment frequency days", with: @loan_type.payment_frequency_days
    fill_in "Profit by payment", with: @loan_type.profit_by_payment
    fill_in "Short name", with: @loan_type.short_name
    fill_in "Total profit", with: @loan_type.total_profit
    click_on "Create Loan type"

    assert_text "Loan type was successfully created"
    click_on "Back"
  end

  test "updating a Loan type" do
    visit loan_types_url
    click_on "Edit", match: :first

    fill_in "Description", with: @loan_type.description
    check "Is profit balane" if @loan_type.is_profit_balane
    fill_in "Late fee", with: @loan_type.late_fee
    fill_in "Late fee profit", with: @loan_type.late_fee_profit
    fill_in "Number of payments", with: @loan_type.number_of_payments
    fill_in "Payment frequency days", with: @loan_type.payment_frequency_days
    fill_in "Profit by payment", with: @loan_type.profit_by_payment
    fill_in "Short name", with: @loan_type.short_name
    fill_in "Total profit", with: @loan_type.total_profit
    click_on "Update Loan type"

    assert_text "Loan type was successfully updated"
    click_on "Back"
  end

  test "destroying a Loan type" do
    visit loan_types_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Loan type was successfully destroyed"
  end
end
