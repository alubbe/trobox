require 'test_helper'

class ApplicationsControllerTest < ActionController::TestCase
  setup do
    @application = applications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:applications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create application" do
    assert_difference('Application.count') do
      post :create, application: { address: @application.address, email: @application.email, immo_id: @application.immo_id, landline: @application.landline, living_space: @application.living_space, mobile: @application.mobile, picture_url: @application.picture_url, price: @application.price, rooms: @application.rooms, title: @application.title, user_id: @application.user_id }
    end

    assert_redirected_to application_path(assigns(:application))
  end

  test "should show application" do
    get :show, id: @application
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @application
    assert_response :success
  end

  test "should update application" do
    patch :update, id: @application, application: { address: @application.address, email: @application.email, immo_id: @application.immo_id, landline: @application.landline, living_space: @application.living_space, mobile: @application.mobile, picture_url: @application.picture_url, price: @application.price, rooms: @application.rooms, title: @application.title, user_id: @application.user_id }
    assert_redirected_to application_path(assigns(:application))
  end

  test "should destroy application" do
    assert_difference('Application.count', -1) do
      delete :destroy, id: @application
    end

    assert_redirected_to applications_path
  end
end
