require 'test_helper'

class TrainerProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trainer_profile = trainer_profiles(:one)
  end

  test "should get index" do
    get trainer_profiles_url
    assert_response :success
  end

  test "should get new" do
    get new_trainer_profile_url
    assert_response :success
  end

  test "should create trainer_profile" do
    assert_difference('TrainerProfile.count') do
      post trainer_profiles_url, params: { trainer_profile: { person_id: @trainer_profile.person_id, primary_job: @trainer_profile.primary_job, secondary_job: @trainer_profile.secondary_job, trainer_type: @trainer_profile.trainer_type } }
    end

    assert_redirected_to trainer_profile_url(TrainerProfile.last)
  end

  test "should show trainer_profile" do
    get trainer_profile_url(@trainer_profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_trainer_profile_url(@trainer_profile)
    assert_response :success
  end

  test "should update trainer_profile" do
    patch trainer_profile_url(@trainer_profile), params: { trainer_profile: { person_id: @trainer_profile.person_id, primary_job: @trainer_profile.primary_job, secondary_job: @trainer_profile.secondary_job, trainer_type: @trainer_profile.trainer_type } }
    assert_redirected_to trainer_profile_url(@trainer_profile)
  end

  test "should destroy trainer_profile" do
    assert_difference('TrainerProfile.count', -1) do
      delete trainer_profile_url(@trainer_profile)
    end

    assert_redirected_to trainer_profiles_url
  end
end
