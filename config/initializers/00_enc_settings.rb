if File.exists? "config/settings.yml"
  ENC_CONFIG = YAML.load_file("#{Rails.root}/config/settings.yml")[Rails.env].with_indifferent_access
elsif File.exists? "/etc/enc_dashboard/settings.yml"
  ENC_CONFIG = YAML.load_file("/etc/enc_dashboard/settings.yml")[Rails.env].with_indifferent_access
else
  puts "WARNING: No config/settings.yml file found"
  ENC_CONFIG = {}
end
