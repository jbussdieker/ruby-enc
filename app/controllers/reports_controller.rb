class ReportsController < ApplicationController
  def index
    @reports = Report.limit(20)
  end

  def show
    @report = Report.find(params[:id])
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
