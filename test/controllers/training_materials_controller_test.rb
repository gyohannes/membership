require 'test_helper'

class TrainingMaterialsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @training_material = training_materials(:one)
  end

  test "should get index" do
    get training_materials_url
    assert_response :success
  end

  test "should get new" do
    get new_training_material_url
    assert_response :success
  end

  test "should create training_material" do
    assert_difference('TrainingMaterial.count') do
      post training_materials_url, params: { training_material: { name: @training_material.name, training_title_id: @training_material.training_title_id } }
    end

    assert_redirected_to training_material_url(TrainingMaterial.last)
  end

  test "should show training_material" do
    get training_material_url(@training_material)
    assert_response :success
  end

  test "should get edit" do
    get edit_training_material_url(@training_material)
    assert_response :success
  end

  test "should update training_material" do
    patch training_material_url(@training_material), params: { training_material: { name: @training_material.name, training_title_id: @training_material.training_title_id } }
    assert_redirected_to training_material_url(@training_material)
  end

  test "should destroy training_material" do
    assert_difference('TrainingMaterial.count', -1) do
      delete training_material_url(@training_material)
    end

    assert_redirected_to training_materials_url
  end
end
