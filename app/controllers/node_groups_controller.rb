class NodeGroupsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @node_groups = NodeGroup.order(sort_column + " " + sort_direction)
  end

  def show
    @node_group = NodeGroup.find(params[:id])
  end

  def new
    @node_group = NodeGroup.new
    @node_group.parameters.build
  end

  def create
    @node_group = NodeGroup.new(params[:node_group])
    if @node_group.save
      redirect_to node_groups_path
    else
      render 'new'
    end
  end

  def edit
    @node_group = NodeGroup.find(params[:id])
    @node_group.parameters.build
  end

  def update
    @node_group = NodeGroup.find(params[:id])
    if @node_group.update_attributes(params[:node_group])
      redirect_to node_groups_path
    else
      render 'edit'
    end
  end

  def destroy
    @node_group = NodeGroup.find(params[:id])
    @node_group.destroy
    redirect_to node_groups_path
  end

  private

  def sort_column
    NodeGroup.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
