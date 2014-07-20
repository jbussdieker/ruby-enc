class PuppetAgentWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely }

  def sync_agent_status
    PuppetAgent.new.each do |result|
      node = Node.find_by_name(result[:sender])
      if node
        node.agent_status = result[:status]
        node.save
      else
        logger.error "sync_agent_status failed to find node for #{result[:sender]}"
      end
    end
  end

  def perform
    Timeout.timeout(60) do
      sync_agent_status
    end
  rescue Exception => error
    logger.error "Exception: #{e.class} (#{e.message})"
    error.backtrace.each do |line|
      logger.error line
    end
  end
end
