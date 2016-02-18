class NodesController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :set_node, only: [:show, :edit, :update, :destroy, :grains, :status_history, :resource_times, :highstate, :highstate_test, :restart_salt]

  def index
    @nodes = Node.order(sort_column + " " + sort_direction)
    render_collection(@nodes)
  end

  def show
    @reports = @node.reports.order("time DESC").page params[:page]

    respond_to do |format|
      format.html # show.html.erb
      format.js # show.js.erb
      format.json { render json: @node }
      format.yaml { render text: @node.to_yaml, content_type: 'text/yaml' }
    end
  end

  def new
    @node = Node.new
  end

  def create
    @node = Node.new(params[:node])
    render_create(@node)
  end

  def update
    render_update(@node, params[:node])
  end

  def destroy
    @node.delete_salt_key
    render_destroy(@node)
  end

  def unresponsive
    @nodes = Node.unresponsive.order(sort_column + " " + sort_direction)
    render_collection(@nodes, 'index')
  end

  def failed
    @nodes = Node.failed.order(sort_column + " " + sort_direction)
    render_collection(@nodes, 'index')
  end

  def pending
    @nodes = Node.pending.order(sort_column + " " + sort_direction)
    render_collection(@nodes, 'index')
  end

  def changed
    @nodes = Node.changed.order(sort_column + " " + sort_direction)
    render_collection(@nodes, 'index')
  end

  def unchanged
    @nodes = Node.unchanged.order(sort_column + " " + sort_direction)
    render_collection(@nodes, 'index')
  end

  def unreported
    @nodes = Node.unreported.order(sort_column + " " + sort_direction)
    render_collection(@nodes, 'index')
  end

  def grains
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @node.grains }
    end
  end

  def resources
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @node.resources }
    end
  end

  def status_history
    render :json => @node.reports.where("time > '#{Time.now - 60*60*24}'").group(:status).count
  end

  def resource_times
    @report = @node.reports.order("time DESC").first
    if @report
      @metrics = @report.metrics.where(:name => "Total")
      @metrics = @metrics.collect {|n| [n.category, n.value]}
    else
      @metrics = []
    end
    render :json => @metrics
  end

  def highstate
    flash[:notice] = "Failed to trigger highstate run on #{@node}" unless @node.highstate
    redirect_to :back
  end

  def highstate_test
    flash[:notice] = "Failed to trigger highstate test run on #{@node}" unless @node.highstate_test
    redirect_to :back
  end

  def restart_salt
    flash[:notice] = "Failed to trigger service.restart for salt on #{@node}" unless @node.restart_salt
    redirect_to :back
  end

  private

  def set_node
    @node = Node.find_by_name(params[:id])
  end

  def sort_column
    Node.column_names.include?(params[:sort]) ? params[:sort] : "reported_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
