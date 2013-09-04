class ReportsController < ApplicationController
  def index
    @reports = Report.limit(20).order("time DESC")
  end

  def show
    @report = Report.find(params[:id])
  end

  def report_history
    @history = Report.group_by_day(:time).count
    # TODO: There has to be a better way
    @history = @history.inject({}) {|o, (k,v)| o[(k||"").split.first] = v; o}
    render :json => @history
  end

  def parse
    @report = Report.find(params[:id])
    @report.parse
    redirect_to reports_path
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy
    redirect_to reports_path
  end

  def upload
    report = Report.create
    report.write(request.raw_post)
    report.parse

    render :text => "OK"
  end
end
