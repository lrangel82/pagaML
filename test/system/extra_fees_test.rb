require "application_system_test_case"

class ExtraFeesTest < ApplicationSystemTestCase
  setup do
    @extra_fee = extra_fees(:one)
  end

  test "visiting the index" do
    visit extra_fees_url
    assert_selector "h1", text: "Extra Fees"
  end

  test "creating a Extra fee" do
    visit extra_fees_url
    click_on "New Extra Fee"

    fill_in "Late fee", with: @extra_fee.late_fee
    fill_in "Late fee profit", with: @extra_fee.late_fee_profit
    fill_in "Loan", with: @extra_fee.loan_id
    fill_in "New balance", with: @extra_fee.new_balance
    fill_in "Old balance", with: @extra_fee.old_balance
    click_on "Create Extra fee"

    assert_text "Extra fee was successfully created"
    click_on "Back"
  end

  test "updating a Extra fee" do
    visit extra_fees_url
    click_on "Edit", match: :first

    fill_in "Late fee", with: @extra_fee.late_fee
    fill_in "Late fee profit", with: @extra_fee.late_fee_profit
    fill_in "Loan", with: @extra_fee.loan_id
    fill_in "New balance", with: @extra_fee.new_balance
    fill_in "Old balance", with: @extra_fee.old_balance
    click_on "Update Extra fee"

    assert_text "Extra fee was successfully updated"
    click_on "Back"
  end

  test "destroying a Extra fee" do
    visit extra_fees_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Extra fee was successfully destroyed"
  end
end
