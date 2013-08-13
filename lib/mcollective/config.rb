module Mcollective
  @@options = {}

  def self.configure(opts = {})
    @@options.merge! opts.dup
  end

  def self.config
    @@options.dup
  end
end
