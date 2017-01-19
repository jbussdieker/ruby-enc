if File.exists? "config/settings.yml"
  ENC_CONFIG = HashWithIndifferentAccess.new(YAML.load(File.read("#{Rails.root}/config/settings.yml"))[Rails.env])
  puts "=> Config file(settings.yml) loaded. \n   ENC_CONFIG: #{ENC_CONFIG}"
elsif File.exists? "/etc/enc_dashboard/settings.yml"
  ENC_CONFIG = HashWithIndifferentAccess.new(YAML.load(File.read("/etc/enc_dashboard/settings.yml"))[Rails.env])
  puts "=> Config file(settings.yml) loaded. \n   ENC_CONFIG: #{ENC_CONFIG}"
else
  puts "WARNING: No config/settings.yml file found"
  ENC_CONFIG = {}
end
