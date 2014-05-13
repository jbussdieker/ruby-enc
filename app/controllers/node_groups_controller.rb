class NodeGroupsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :set_node_group, only: [:show, :edit, :update, :destroy]

  def index
    @node_groups = NodeGroup.order(sort_column + " " + sort_direction)
    render_index(@node_groups)
  end

  def show
    @nodes = @node_group.nodes.order(sort_column + " " + sort_direction)
    render_show(@node_group)
  end

  def new
    @node_group = NodeGroup.new
  end

  def create
    @node_group = NodeGroup.new(node_group_params)
    render_create(@node_group)
  end

  def update
    render_update(@node_group, node_group_params)
  end

  def destroy
    render_destroy(@node_group)
  end

  private

  def set_node_group
    @node_group = NodeGroup.find_by_name(params[:id])
  end

  def node_group_params
    params.require(:node_group).permit(:name, parameters_attributes: [ :key, :value, :_destroy ])
  end

  def sort_column
    params[:sort] || "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
