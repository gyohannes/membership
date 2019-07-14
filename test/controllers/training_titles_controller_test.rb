require 'test_helper'

class TrainingTitlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @training_title = training_titles(:one)
  end

  test "should get index" do
    get training_titles_url
    assert_response :success
  end

  test "should get new" do
    get new_training_title_url
    assert_response :success
  end

  test "should create training_title" do
    assert_difference('TrainingTitle.count') do
      post training_titles_url, params: { training_title: { description: @training_title.description, program_area_id: @training_title.program_area_id, title: @training_title.title } }
    end

    assert_redirected_to training_title_url(TrainingTitle.last)
  end

  test "should show training_title" do
    get training_title_url(@training_title)
    assert_response :success
  end

  test "should get edit" do
    get edit_training_title_url(@training_title)
    assert_response :success
  end

  test "should update training_title" do
    patch training_title_url(@training_title), params: { training_title: { description: @training_title.description, program_area_id: @training_title.program_area_id, title: @training_title.title } }
    assert_redirected_to training_title_url(@training_title)
  end

  test "should destroy training_title" do
    assert_difference('TrainingTitle.count', -1) do
      delete training_title_url(@training_title)
    end

    assert_redirected_to training_titles_url
  end
end
