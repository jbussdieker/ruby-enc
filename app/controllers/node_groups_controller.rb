class NodeGroupsController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :set_node_group, only: [:show, :edit, :update, :destroy]

  def index
    @node_groups = NodeGroup.order(sort_column + " " + sort_direction)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @node_groups.to_json(:include => {
        :parameters => {}
      }) }
    end
  end

  def show
    @nodes = @node_group.nodes.order(sort_column + " " + sort_direction)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @node_group.to_json(:include => {
        :parameters => {}
      }) }
    end
  end

  def new
    @node_group = NodeGroup.new
  end

  def edit
  end

  def create
    @node_group = NodeGroup.new(params[:node_group])

    render_create(@node_group)
  end

  def update
    render_update(@node_group, params[:node_group])
  end

  def destroy
    render_destroy(@node_group)
  end

  private

  def set_node_group
    @node_group = NodeGroup.find_by_name(params[:id])
  end

  def sort_column
    params[:sort] || "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
