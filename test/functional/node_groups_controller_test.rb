require 'test_helper'

class NodeGroupsControllerTest < ActionController::TestCase
  setup do
    @node_group = node_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:node_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create node group" do
    assert_difference('NodeGroup.count') do
      post :create, node_group: { name: @node_group.name + "unique" }
    end

    assert_redirected_to node_group_path(assigns(:node_group))
  end

  test "should show node group" do
    get :show, id: @node_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @node_group
    assert_response :success
  end

  test "should update node group" do
    put :update, id: @node_group, node_group: { name: @node_group.name }
    assert_redirected_to node_group_path(assigns(:node_group))
  end

  test "should destroy node group" do
    assert_difference('NodeGroup.count', -1) do
      delete :destroy, id: @node_group
    end

    assert_redirected_to node_groups_path
  end
end
