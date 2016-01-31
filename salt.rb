pid_file = File.join(Rails.root, "tmp", "pids", "worker.pid")
File.open(pid_file, 'w') do |f|
  f.write($$)
end

at_exit do
  File.delete(pid_file)
end

$stdout.sync = true

while true do
  begin
    err = Salt::Api.events do |event|
      SaltEvent.new(event).handle
    end

    puts "Error reading events: #{err}"
    puts err.backtrace.join("\n")
  rescue Interrupt => err
    puts "Gracefully exiting..."
    exit 0
  rescue Exception => err
    puts "Unhandled exception: #{err}"
    puts err.backtrace.join("\n")
  end

  puts "Reconnecting in 10 seconds..."
  sleep 10
end

