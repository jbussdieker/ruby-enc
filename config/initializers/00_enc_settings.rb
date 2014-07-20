module Enc
  class Config
    attr_accessor :puppetdb_host, :puppetdb_port, :spool_path

    def initialize
      puppetdb_host = puppetdb[:host]
      puppetdb_port = puppetdb[:port]
      spool_path = data[:spool_path]
    end

    def puppetdb
      data[:puppetdb] || {}
    end

    def data
      @data ||= load_config
    end

    def config_file
      "#{Rails.root}/config/settings.yml"
    end

    def load_config
      if File.exists? config_file
        parsed = YAML.load_file(config_file)
        parsed = parsed[Rails.env] || {}
        parsed.with_indifferent_access
      end
    end
  end

  def self.config
    @config ||= Config.new
  end
end
