module Enc
  class Config
    attr_accessor :puppetdb_host, :puppetdb_port

    def initialize
      config = load_config || {}
      puppetdb_host = config[:puppetdb_host]
      puppetdb_port = config[:puppetdb_port]
    end

    def config_file
      "#{Rails.root}/config/settings.yml"
    end

    def load_config
      if File.exists? config_file
        data = YAML.load_file(config_file)
        data = data[Rails.env] || {}
        data.with_indifferent_access
      end
    end
  end

  def self.config
    @config ||= Config.new
  end
end
