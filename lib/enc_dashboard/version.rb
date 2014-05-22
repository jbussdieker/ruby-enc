module EncDashboard
  VERSION = lambda {
    version = File.read("VERSION").strip
    if File.exists?("JENKINS")
      version += "."
      version += File.read("JENKINS").strip
    end
    version
  }.yield
end
