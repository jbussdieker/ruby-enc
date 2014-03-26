class ReportCleaning
  def initialize(age = 7.days.ago)
    @age = age
  end


  def clean
    Report.where("created_at < ?", @age).destroy_all
  end
end
