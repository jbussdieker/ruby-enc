class ReportsController < ApplicationController
  def index
    @reports = Report.order("time DESC").page params[:page]
  end

  def show
    @report = Report.find(params[:id])
  end

  def report_history
    begin
      @history = Report.group_by_day(:time).count

      # TODO: There has to be a better way
      @history.reject! {|k,v| k == nil}
      @history = @history.inject({}) do |o, (k,v)|
        kk = Time.parse(k.to_s)
        o[kk.to_date] = v
        o
      end
    rescue RuntimeError => e
      @history = {}
    end

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
