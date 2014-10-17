class PuppetAgent
  include Enumerable
  include MCollective::RPC

  def each(&block)
    (results || []).each { |result| yield(result) }
  end

  def find_by_sender(sender)
    find { |item| item.results[:sender] == sender }
  end

  [:status, :enabled, :running, :idling, :stopped, :lastrun, :output].each do |method|
    define_method method do
      inject({}) { |v,item| v[item[:sender]] = item[:data][method]; v }
    end
  end

  def results
    @results ||= get_statuses
  end

  def node_status(fqdn)
    mc = rpcclient("puppetd").tap do |mc|
      mc.progress = false
      mc.fact_filter "fqdn", fqdn
    end
    mc.status.first.results[:data][:status]
  rescue Exception => e
    Rails.logger.error e.message
    Rails.logger.error e.backtrace.join("\n")
    nil
  end

  def disable(fqdn)
    rpcclient("puppetd").tap do |mc|
      mc.progress = false
      mc.fact_filter "fqdn", fqdn
      mc.disable
    end
  rescue Exception => e
    Rails.logger.error e.message
    Rails.logger.error e.backtrace.join("\n")
    nil
  end

  def runonce(fqdn)
    rpcclient("puppetd").tap do |mc|
      mc.progress = false
      mc.fact_filter "fqdn", fqdn
      mc.runonce
    end
  rescue Exception => e
    Rails.logger.error e.message
    Rails.logger.error e.backtrace.join("\n")
    nil
  end

  def enable(fqdn)
    rpcclient("puppetd").tap do |mc|
      mc.progress = false
      mc.fact_filter "fqdn", fqdn
      mc.enable
    end
  rescue Exception => e
    Rails.logger.error e.message
    Rails.logger.error e.backtrace.join("\n")
    nil
  end

  private

  def agent
    rpcclient("puppetd").tap do |mc|
      mc.progress = false
    end
  end

  def get_statuses
    agent.status
  rescue Exception => e
    Rails.logger.error e.message
    Rails.logger.error e.backtrace.join("\n")
    nil
  end
end
