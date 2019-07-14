require 'test_helper'

class TraineeDistributionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trainee_distribution = trainee_distributions(:one)
  end

  test "should get index" do
    get trainee_distributions_url
    assert_response :success
  end

  test "should get new" do
    get new_trainee_distribution_url
    assert_response :success
  end

  test "should create trainee_distribution" do
    assert_difference('TraineeDistribution.count') do
      post trainee_distributions_url, params: { trainee_distribution: { number_of_trainees: @trainee_distribution.number_of_trainees, organization_unit_id: @trainee_distribution.organization_unit_id, training_id: @trainee_distribution.training_id } }
    end

    assert_redirected_to trainee_distribution_url(TraineeDistribution.last)
  end

  test "should show trainee_distribution" do
    get trainee_distribution_url(@trainee_distribution)
    assert_response :success
  end

  test "should get edit" do
    get edit_trainee_distribution_url(@trainee_distribution)
    assert_response :success
  end

  test "should update trainee_distribution" do
    patch trainee_distribution_url(@trainee_distribution), params: { trainee_distribution: { number_of_trainees: @trainee_distribution.number_of_trainees, organization_unit_id: @trainee_distribution.organization_unit_id, training_id: @trainee_distribution.training_id } }
    assert_redirected_to trainee_distribution_url(@trainee_distribution)
  end

  test "should destroy trainee_distribution" do
    assert_difference('TraineeDistribution.count', -1) do
      delete trainee_distribution_url(@trainee_distribution)
    end

    assert_redirected_to trainee_distributions_url
  end
end
