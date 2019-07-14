require 'test_helper'

class OrganizationUnitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization_unit = organization_units(:one)
  end

  test "should get index" do
    get organization_units_url
    assert_response :success
  end

  test "should get new" do
    get new_organization_unit_url
    assert_response :success
  end

  test "should create organization_unit" do
    assert_difference('OrganizationUnit.count') do
      post organization_units_url, params: { organization_unit: { latitude: @organization_unit.latitude, longtitude: @organization_unit.longtitude, name: @organization_unit.name, organization_type_id: @organization_unit.organization_type_id, parent_organization_unit_id: @organization_unit.parent_organization_unit_id, short_name: @organization_unit.short_name, url: @organization_unit.url } }
    end

    assert_redirected_to organization_unit_url(OrganizationUnit.last)
  end

  test "should show organization_unit" do
    get organization_unit_url(@organization_unit)
    assert_response :success
  end

  test "should get edit" do
    get edit_organization_unit_url(@organization_unit)
    assert_response :success
  end

  test "should update organization_unit" do
    patch organization_unit_url(@organization_unit), params: { organization_unit: { latitude: @organization_unit.latitude, longtitude: @organization_unit.longtitude, name: @organization_unit.name, organization_type_id: @organization_unit.organization_type_id, parent_organization_unit_id: @organization_unit.parent_organization_unit_id, short_name: @organization_unit.short_name, url: @organization_unit.url } }
    assert_redirected_to organization_unit_url(@organization_unit)
  end

  test "should destroy organization_unit" do
    assert_difference('OrganizationUnit.count', -1) do
      delete organization_unit_url(@organization_unit)
    end

    assert_redirected_to organization_units_url
  end
end
