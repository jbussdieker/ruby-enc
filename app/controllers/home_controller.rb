class HomeController < ApplicationController
  def moov_check
    if File.exists? File.join(Rails.root, "/public/moov_check.txt")
      render json: { message: "OK" }
    else
      error_msg = "moov_check disabled by user. '/public/moov_check.txt' does not exist."
      Rails.logger.error(error_msg)
      render json: { message: error_msg }, status: 500
    end
  end
end
