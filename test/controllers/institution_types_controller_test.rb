require 'test_helper'

class InstitutionTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @institution_type = institution_types(:one)
  end

  test "should get index" do
    get institution_types_url
    assert_response :success
  end

  test "should get new" do
    get new_institution_type_url
    assert_response :success
  end

  test "should create institution_type" do
    assert_difference('InstitutionType.count') do
      post institution_types_url, params: { institution_type: { description: @institution_type.description, name: @institution_type.name } }
    end

    assert_redirected_to institution_type_url(InstitutionType.last)
  end

  test "should show institution_type" do
    get institution_type_url(@institution_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_institution_type_url(@institution_type)
    assert_response :success
  end

  test "should update institution_type" do
    patch institution_type_url(@institution_type), params: { institution_type: { description: @institution_type.description, name: @institution_type.name } }
    assert_redirected_to institution_type_url(@institution_type)
  end

  test "should destroy institution_type" do
    assert_difference('InstitutionType.count', -1) do
      delete institution_type_url(@institution_type)
    end

    assert_redirected_to institution_types_url
  end
end
