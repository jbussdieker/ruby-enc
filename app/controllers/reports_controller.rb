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

    if relay_settings = ENC_CONFIG[:report_relay]
      client = Net::HTTP.new(relay_settings[:host], relay_settings[:port])
      req = Net::HTTP::Post.new("/reports/upload")
      req["Content-Type"] = "application/x-yaml"
      req.body = request.raw_post
      resp = client.request(req)
    end

    render :text => "OK"
  end
end
