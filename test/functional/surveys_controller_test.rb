require 'test_helper'

class SurveysControllerTest < ActionController::TestCase

  setup do
    @survey = Fabricate(:survey)
    @user = Fabricate(:user)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:surveys)
    assert_select '#unexpected_error', false
    assert_template "surveys/index"
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:survey)
    assert_select '#unexpected_error', false
    assert_template "surveys/new"
  end

  test "should create survey" do
    assert_difference('Survey.count') do
      post :create, survey: Fabricate.attributes_for(:survey)
    end

    assert_redirected_to survey_url(assigns(:survey))
  end

  test "should show survey" do
    get :show, id: @survey
    assert_response :success
    assert_not_nil assigns(:survey)
    assert_select '#unexpected_error', false
    assert_template "surveys/show"
  end
end
