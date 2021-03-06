worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout (ENV["UNICORN_TIMEOUT"] || 15).to_i
preload_app true

before_fork do |server, worker|
  @sidekiq_pid ||= spawn("env TERM_CHILD=1 RESQUE_TERM_TIMEOUT=8 bundle exec rake resque:work")
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
