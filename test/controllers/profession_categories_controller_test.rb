require 'test_helper'

class ProfessionCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profession_category = profession_categories(:one)
  end

  test "should get index" do
    get profession_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_profession_category_url
    assert_response :success
  end

  test "should create profession_category" do
    assert_difference('ProfessionCategory.count') do
      post profession_categories_url, params: { profession_category: { name: @profession_category.name } }
    end

    assert_redirected_to profession_category_url(ProfessionCategory.last)
  end

  test "should show profession_category" do
    get profession_category_url(@profession_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_profession_category_url(@profession_category)
    assert_response :success
  end

  test "should update profession_category" do
    patch profession_category_url(@profession_category), params: { profession_category: { name: @profession_category.name } }
    assert_redirected_to profession_category_url(@profession_category)
  end

  test "should destroy profession_category" do
    assert_difference('ProfessionCategory.count', -1) do
      delete profession_category_url(@profession_category)
    end

    assert_redirected_to profession_categories_url
  end
end
