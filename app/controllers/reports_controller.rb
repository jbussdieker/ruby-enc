class ReportsController < ApplicationController
  before_filter :set_report, only: [:show, :parse, :destroy]

  def index
    @reports = Report.order("time DESC").page params[:page]
  end

  def show
  end

  def report_history
    @history = Report.group_by_day(:time).count

    # TODO: There has to be a better way
    @history.reject! {|k,v| k == nil}
    @history = @history.inject({}) do |o, (k,v)|
      kk = Time.parse(k.to_s)
      o[kk.to_date] = v
      o
    end

    render :json => @history
  end

  def parse
    @report.parse
    redirect_to reports_path
  end

  def destroy
    @report.destroy
    redirect_to reports_path
  end

  def upload
    report = Report.create
    report.write(request.raw_post)
    report.parse

    render :text => "OK"
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end
end
