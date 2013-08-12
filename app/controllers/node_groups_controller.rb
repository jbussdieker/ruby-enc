class NodeGroupsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @node_groups = NodeGroup.order(sort_column + " " + sort_direction)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @node_groups }
    end
  end

  def show
    @node_group = NodeGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @node_group }
    end
  end

  def new
    @node_group = NodeGroup.new
    @node_group.parameters.build
  end

  def edit
    @node_group = NodeGroup.find(params[:id])
    @node_group.parameters.build
  end

  def create
    @node_group = NodeGroup.new(params[:node_group])

    respond_to do |format|
      if @node_group.save
        format.html { redirect_to @node_group, notice: 'Node group was successfully created.' }
        format.json { render json: @node_group, status: :created, location: @node_group }
      else
        format.html { render action: "new" }
        format.json { render json: @node_group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @node_group = NodeGroup.find(params[:id])

    respond_to do |format|
      if @node_group.update_attributes(params[:node_group])
        format.html { redirect_to @node_group, notice: 'Node group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @node_group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @node_group = NodeGroup.find(params[:id])
    @node_group.destroy

    respond_to do |format|
      format.html { redirect_to node_groups_path }
      format.json { head :no_content }
    end
  end

  private

  def sort_column
    NodeGroup.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
