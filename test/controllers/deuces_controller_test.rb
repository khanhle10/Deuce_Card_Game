require 'test_helper'

class DeucesControllerTest < ActionController::TestCase
  setup do
    @deuce = deuces(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deuces)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create deuce" do
    assert_difference('Deuce.count') do
      post :create, deuce: { name: @deuce.name, player1: @deuce.player1, player2: @deuce.player2, player3: @deuce.player3, player4: @deuce.player4, player_count: @deuce.player_count }
    end

    assert_redirected_to deuce_path(assigns(:deuce))
  end

  test "should show deuce" do
    get :show, id: @deuce
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @deuce
    assert_response :success
  end

  test "should update deuce" do
    patch :update, id: @deuce, deuce: { name: @deuce.name, player1: @deuce.player1, player2: @deuce.player2, player3: @deuce.player3, player4: @deuce.player4, player_count: @deuce.player_count }
    assert_redirected_to deuce_path(assigns(:deuce))
  end

  test "should destroy deuce" do
    assert_difference('Deuce.count', -1) do
      delete :destroy, id: @deuce
    end

    assert_redirected_to deuces_path
  end
end
