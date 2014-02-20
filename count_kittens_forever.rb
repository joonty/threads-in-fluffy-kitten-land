require 'net/http'
require 'thread'

$: << "lib"
require 'kitten'
require 'kitten_counter'
require 'catflap'
require 'thread_manager'

Thread.abort_on_exception = true

gateway = Catflap.new(URI("http://localhost:4567/register_kitten"))
counter = KittenCounter.new(0)
counter_threads = ARGV.first.to_i > 0 ? ARGV.first.to_i : 4
kittens_in = Queue.new

threads = ThreadManager.new(counter_threads, gateway, counter)
threads.start(kittens_in, false)

reset_proc = proc do
  puts "\e[H\e[2J"
  puts "Welcome to the fluffy kitten counter\n\n"
  puts counter.formatted_result
  puts "#{counter.kittens_per_second} kittens per second"
end
reset_proc.call

loop do
  trap "SIGQUIT", reset_proc
  while line = STDIN.gets
    kittens_in << line
  end
end
