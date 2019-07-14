require 'test_helper'

class MembershipTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @membership_type = membership_types(:one)
  end

  test "should get index" do
    get membership_types_url
    assert_response :success
  end

  test "should get new" do
    get new_membership_type_url
    assert_response :success
  end

  test "should create membership_type" do
    assert_difference('MembershipType.count') do
      post membership_types_url, params: { membership_type: { description: @membership_type.description, name: @membership_type.name } }
    end

    assert_redirected_to membership_type_url(MembershipType.last)
  end

  test "should show membership_type" do
    get membership_type_url(@membership_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_membership_type_url(@membership_type)
    assert_response :success
  end

  test "should update membership_type" do
    patch membership_type_url(@membership_type), params: { membership_type: { description: @membership_type.description, name: @membership_type.name } }
    assert_redirected_to membership_type_url(@membership_type)
  end

  test "should destroy membership_type" do
    assert_difference('MembershipType.count', -1) do
      delete membership_type_url(@membership_type)
    end

    assert_redirected_to membership_types_url
  end
end
