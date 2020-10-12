require "application_system_test_case"

class PaymentsTest < ApplicationSystemTestCase
  setup do
    @payment = payments(:one)
  end

  test "visiting the index" do
    visit payments_url
    assert_selector "h1", text: "Payments"
  end

  test "creating a Payment" do
    visit payments_url
    click_on "New Payment"

    fill_in "Amount", with: @payment.amount
    fill_in "Loan", with: @payment.loan_id
    fill_in "Payment date", with: @payment.payment_date
    fill_in "Payment to borrowed", with: @payment.payment_to_borrowed
    fill_in "Profit", with: @payment.profit
    fill_in "Status", with: @payment.status_id
    click_on "Create Payment"

    assert_text "Payment was successfully created"
    click_on "Back"
  end

  test "updating a Payment" do
    visit payments_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @payment.amount
    fill_in "Loan", with: @payment.loan_id
    fill_in "Payment date", with: @payment.payment_date
    fill_in "Payment to borrowed", with: @payment.payment_to_borrowed
    fill_in "Profit", with: @payment.profit
    fill_in "Status", with: @payment.status_id
    click_on "Update Payment"

    assert_text "Payment was successfully updated"
    click_on "Back"
  end

  test "destroying a Payment" do
    visit payments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Payment was successfully destroyed"
  end
end
