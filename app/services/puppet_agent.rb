class PuppetAgent
  include Enumerable
  include MCollective::RPC

  def each(&block)
    results.each { |result| yield(result) }
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

  def disable(fqdn)
    rpcclient("puppetd").tap do |mc|
      mc.progress = false
      mc.fact_filter "fqdn", fqdn
      mc.disable
    end
  end

  def enable(fqdn)
    rpcclient("puppetd").tap do |mc|
      mc.progress = false
      mc.fact_filter "fqdn", fqdn
      mc.enable
    end
  end

  private

  def agent
    rpcclient("puppetd").tap do |mc|
      mc.progress = false
    end
  end

  def get_statuses
    agent.status
  end
end
