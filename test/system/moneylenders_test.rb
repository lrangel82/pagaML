require "application_system_test_case"

class MoneylendersTest < ApplicationSystemTestCase
  setup do
    @moneylender = moneylenders(:one)
  end

  test "visiting the index" do
    visit moneylenders_url
    assert_selector "h1", text: "Moneylenders"
  end

  test "creating a Moneylender" do
    visit moneylenders_url
    click_on "New Moneylender"

    fill_in "Account number", with: @moneylender.account_number
    fill_in "Alias", with: @moneylender.alias
    fill_in "Bank", with: @moneylender.bank
    fill_in "Clabe", with: @moneylender.clabe
    click_on "Create Moneylender"

    assert_text "Moneylender was successfully created"
    click_on "Back"
  end

  test "updating a Moneylender" do
    visit moneylenders_url
    click_on "Edit", match: :first

    fill_in "Account number", with: @moneylender.account_number
    fill_in "Alias", with: @moneylender.alias
    fill_in "Bank", with: @moneylender.bank
    fill_in "Clabe", with: @moneylender.clabe
    click_on "Update Moneylender"

    assert_text "Moneylender was successfully updated"
    click_on "Back"
  end

  test "destroying a Moneylender" do
    visit moneylenders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Moneylender was successfully destroyed"
  end
end
