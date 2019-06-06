require 'test_helper'

class MpAmountSettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mp_amount_setting = mp_amount_settings(:one)
  end

  test "should get index" do
    get mp_amount_settings_url
    assert_response :success
  end

  test "should get new" do
    get new_mp_amount_setting_url
    assert_response :success
  end

  test "should create mp_amount_setting" do
    assert_difference('MpAmountSetting.count') do
      post mp_amount_settings_url, params: { mp_amount_setting: { amount: @mp_amount_setting.amount, description: @mp_amount_setting.description, membership_type_id: @mp_amount_setting.membership_type_id, mp_year_id: @mp_amount_setting.mp_year_id, name: @mp_amount_setting.name } }
    end

    assert_redirected_to mp_amount_setting_url(MpAmountSetting.last)
  end

  test "should show mp_amount_setting" do
    get mp_amount_setting_url(@mp_amount_setting)
    assert_response :success
  end

  test "should get edit" do
    get edit_mp_amount_setting_url(@mp_amount_setting)
    assert_response :success
  end

  test "should update mp_amount_setting" do
    patch mp_amount_setting_url(@mp_amount_setting), params: { mp_amount_setting: { amount: @mp_amount_setting.amount, description: @mp_amount_setting.description, membership_type_id: @mp_amount_setting.membership_type_id, mp_year_id: @mp_amount_setting.mp_year_id, name: @mp_amount_setting.name } }
    assert_redirected_to mp_amount_setting_url(@mp_amount_setting)
  end

  test "should destroy mp_amount_setting" do
    assert_difference('MpAmountSetting.count', -1) do
      delete mp_amount_setting_url(@mp_amount_setting)
    end

    assert_redirected_to mp_amount_settings_url
  end
end
