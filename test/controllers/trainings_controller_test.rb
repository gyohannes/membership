require 'test_helper'

class TrainingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @training = trainings(:one)
  end

  test "should get index" do
    get trainings_url
    assert_response :success
  end

  test "should get new" do
    get new_training_url
    assert_response :success
  end

  test "should create training" do
    assert_difference('Training.count') do
      post trainings_url, params: { training: { duration: @training.duration, duration_in: @training.duration_in, end_time: @training.end_time, expected_number_of_trainees: @training.expected_number_of_trainees, institution_id: @training.institution_id, organization_unit_id: @training.organization_unit_id, start_time: @training.start_time, training_method: @training.training_method, training_title_id: @training.training_title_id } }
    end

    assert_redirected_to training_url(Training.last)
  end

  test "should show training" do
    get training_url(@training)
    assert_response :success
  end

  test "should get edit" do
    get edit_training_url(@training)
    assert_response :success
  end

  test "should update training" do
    patch training_url(@training), params: { training: { duration: @training.duration, duration_in: @training.duration_in, end_time: @training.end_time, expected_number_of_trainees: @training.expected_number_of_trainees, institution_id: @training.institution_id, organization_unit_id: @training.organization_unit_id, start_time: @training.start_time, training_method: @training.training_method, training_title_id: @training.training_title_id } }
    assert_redirected_to training_url(@training)
  end

  test "should destroy training" do
    assert_difference('Training.count', -1) do
      delete training_url(@training)
    end

    assert_redirected_to trainings_url
  end
end
