class SaltEventStatus
  attr_accessor :id, :status

  def initialize(id, status)
    @id = id
    @status = status
  end

  def run_num
    status['__run_num__']
  end

  def comment
    status['comment']
  end

  def name
    status['name']
  end

  def start_time
    status['start_time']
  end

  def result
    status['result']
  end

  def duration
    status['duration']
  end

  def changes
    status['changes']
  end
end
