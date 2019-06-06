require 'test_helper'

class ProgramAreasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @program_area = program_areas(:one)
  end

  test "should get index" do
    get program_areas_url
    assert_response :success
  end

  test "should get new" do
    get new_program_area_url
    assert_response :success
  end

  test "should create program_area" do
    assert_difference('ProgramArea.count') do
      post program_areas_url, params: { program_area: { description: @program_area.description, name: @program_area.name } }
    end

    assert_redirected_to program_area_url(ProgramArea.last)
  end

  test "should show program_area" do
    get program_area_url(@program_area)
    assert_response :success
  end

  test "should get edit" do
    get edit_program_area_url(@program_area)
    assert_response :success
  end

  test "should update program_area" do
    patch program_area_url(@program_area), params: { program_area: { description: @program_area.description, name: @program_area.name } }
    assert_redirected_to program_area_url(@program_area)
  end

  test "should destroy program_area" do
    assert_difference('ProgramArea.count', -1) do
      delete program_area_url(@program_area)
    end

    assert_redirected_to program_areas_url
  end
end
