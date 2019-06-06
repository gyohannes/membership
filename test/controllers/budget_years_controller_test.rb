require 'test_helper'

class BudgetYearsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @budget_year = budget_years(:one)
  end

  test "should get index" do
    get budget_years_url
    assert_response :success
  end

  test "should get new" do
    get new_budget_year_url
    assert_response :success
  end

  test "should create budget_year" do
    assert_difference('BudgetYear.count') do
      post budget_years_url, params: { budget_year: { from: @budget_year.from, name: @budget_year.name, status: @budget_year.status, to: @budget_year.to } }
    end

    assert_redirected_to budget_year_url(BudgetYear.last)
  end

  test "should show budget_year" do
    get budget_year_url(@budget_year)
    assert_response :success
  end

  test "should get edit" do
    get edit_budget_year_url(@budget_year)
    assert_response :success
  end

  test "should update budget_year" do
    patch budget_year_url(@budget_year), params: { budget_year: { from: @budget_year.from, name: @budget_year.name, status: @budget_year.status, to: @budget_year.to } }
    assert_redirected_to budget_year_url(@budget_year)
  end

  test "should destroy budget_year" do
    assert_difference('BudgetYear.count', -1) do
      delete budget_year_url(@budget_year)
    end

    assert_redirected_to budget_years_url
  end
end
