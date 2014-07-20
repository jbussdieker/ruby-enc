module Enc
  class Config
    attr_accessor :puppetdb_host, :puppetdb_port, :spool_path

    def initialize
      config = load_config || {}
      puppetdb_host = config[:puppetdb].try([:host])
      puppetdb_port = config[:puppetdb].try([:port])
      spool_path = config[:spool_path]
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
