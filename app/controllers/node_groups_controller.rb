class NodeGroupsController < ApplicationController
  def index
    @node_groups = NodeGroup.all
  end

  def new
    @node_group = NodeGroup.new
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
end
