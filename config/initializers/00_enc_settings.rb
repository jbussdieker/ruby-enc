ENC_CONFIG = YAML.load_file("#{Rails.root}/config/settings.yml")[Rails.env].with_indifferent_access
