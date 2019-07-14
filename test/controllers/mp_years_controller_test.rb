require 'test_helper'

class MpYearsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mp_year = mp_years(:one)
  end

  test "should get index" do
    get mp_years_url
    assert_response :success
  end

  test "should get new" do
    get new_mp_year_url
    assert_response :success
  end

  test "should create mp_year" do
    assert_difference('MpYear.count') do
      post mp_years_url, params: { mp_year: { description: @mp_year.description, from: @mp_year.from, name: @mp_year.name, status: @mp_year.status, to: @mp_year.to } }
    end

    assert_redirected_to mp_year_url(MpYear.last)
  end

  test "should show mp_year" do
    get mp_year_url(@mp_year)
    assert_response :success
  end

  test "should get edit" do
    get edit_mp_year_url(@mp_year)
    assert_response :success
  end

  test "should update mp_year" do
    patch mp_year_url(@mp_year), params: { mp_year: { description: @mp_year.description, from: @mp_year.from, name: @mp_year.name, status: @mp_year.status, to: @mp_year.to } }
    assert_redirected_to mp_year_url(@mp_year)
  end

  test "should destroy mp_year" do
    assert_difference('MpYear.count', -1) do
      delete mp_year_url(@mp_year)
    end

    assert_redirected_to mp_years_url
  end
end
