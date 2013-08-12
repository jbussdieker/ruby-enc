require 'test_helper'

class NodeClassesControllerTest < ActionController::TestCase
  setup do
    @node_class = node_classes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:node_classes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create node class" do
    assert_difference('NodeClass.count') do
      post :create, node_class: { name: @node_class.name + "unique" }
    end

    assert_redirected_to node_class_path(assigns(:node_class))
  end

  test "should show node class" do
    get :show, id: @node_class
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @node_class
    assert_response :success
  end

  test "should update node class" do
    put :update, id: @node_class, node_class: { name: @node_class.name }
    assert_redirected_to node_class_path(assigns(:node_class))
  end

  test "should destroy node class" do
    assert_difference('NodeClass.count', -1) do
      delete :destroy, id: @node_class
    end

    assert_redirected_to node_classes_path
  end
end
