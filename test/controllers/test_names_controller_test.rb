require 'test_helper'

class TestNamesControllerTest < ActionController::TestCase
  setup do
    @test_name = test_names(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:test_names)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create test_name" do
    assert_difference('TestName.count') do
      post :create, test_name: { name: @test_name.name }
    end

    assert_redirected_to test_name_path(assigns(:test_name))
  end

  test "should show test_name" do
    get :show, id: @test_name
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @test_name
    assert_response :success
  end

  test "should update test_name" do
    patch :update, id: @test_name, test_name: { name: @test_name.name }
    assert_redirected_to test_name_path(assigns(:test_name))
  end

  test "should destroy test_name" do
    assert_difference('TestName.count', -1) do
      delete :destroy, id: @test_name
    end

    assert_redirected_to test_names_path
  end
end
