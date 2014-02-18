require 'net/http'
require 'thread'

$: << "lib"
require 'kitten'
require 'kitten_counter'
require 'kitten_gateway'
require 'thread_manager'

Thread.abort_on_exception = true

gateway = KittenGateway.new(URI("http://localhost:4567/register_kitten"))
counter = KittenCounter.new
counter_threads = ARGV.first.to_i > 0 ? ARGV.first.to_i : 4
kittens_in = Queue.new

threads = ThreadManager.new(counter_threads, gateway, counter)
threads.start(kittens_in)

while line = STDIN.gets
  kittens_in << line
end

until kittens_in.empty? && threads.all_inactive?
  sleep 0.1
end

puts counter.formatted_result
puts "Thanks, shutting down..."
threads.stop
