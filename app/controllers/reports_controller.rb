class ReportsController < ApplicationController
  def index
    @reports = Report.limit(20).order("time DESC")
  end

  def show
    @report = Report.find(params[:id])
  end

  def report_history
    render :json => Report.group_by_day(:time).count
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
