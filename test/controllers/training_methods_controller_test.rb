require 'test_helper'

class TrainingMethodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @training_method = training_methods(:one)
  end

  test "should get index" do
    get training_methods_url
    assert_response :success
  end

  test "should get new" do
    get new_training_method_url
    assert_response :success
  end

  test "should create training_method" do
    assert_difference('TrainingMethod.count') do
      post training_methods_url, params: { training_method: { description: @training_method.description, name: @training_method.name } }
    end

    assert_redirected_to training_method_url(TrainingMethod.last)
  end

  test "should show training_method" do
    get training_method_url(@training_method)
    assert_response :success
  end

  test "should get edit" do
    get edit_training_method_url(@training_method)
    assert_response :success
  end

  test "should update training_method" do
    patch training_method_url(@training_method), params: { training_method: { description: @training_method.description, name: @training_method.name } }
    assert_redirected_to training_method_url(@training_method)
  end

  test "should destroy training_method" do
    assert_difference('TrainingMethod.count', -1) do
      delete training_method_url(@training_method)
    end

    assert_redirected_to training_methods_url
  end
end
