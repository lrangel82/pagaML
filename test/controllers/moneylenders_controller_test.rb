require 'test_helper'

class MoneylendersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @moneylender = moneylenders(:one)
  end

  test "should get index" do
    get moneylenders_url
    assert_response :success
  end

  test "should get new" do
    get new_moneylender_url
    assert_response :success
  end

  test "should create moneylender" do
    assert_difference('Moneylender.count') do
      post moneylenders_url, params: { moneylender: { account_number: @moneylender.account_number, alias: @moneylender.alias, bank: @moneylender.bank, clabe: @moneylender.clabe } }
    end

    assert_redirected_to moneylender_url(Moneylender.last)
  end

  test "should show moneylender" do
    get moneylender_url(@moneylender)
    assert_response :success
  end

  test "should get edit" do
    get edit_moneylender_url(@moneylender)
    assert_response :success
  end

  test "should update moneylender" do
    patch moneylender_url(@moneylender), params: { moneylender: { account_number: @moneylender.account_number, alias: @moneylender.alias, bank: @moneylender.bank, clabe: @moneylender.clabe } }
    assert_redirected_to moneylender_url(@moneylender)
  end

  test "should destroy moneylender" do
    assert_difference('Moneylender.count', -1) do
      delete moneylender_url(@moneylender)
    end

    assert_redirected_to moneylenders_url
  end
end
