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

    puts "FORWARD ================================"
    # Forward report hack
    client = Net::HTTP.new("localhost", 3000)
    req = Net::HTTP::Post.new("/reports/upload")
    req["Content-Type"] = "application/x-yaml"
    req.body = request.raw_post
    resp = client.request(req)
    p resp
    puts "MARCH ================================"

    render :text => "OK"
  end
end
