$: << "lib"

require 'net/http'
require 'thread'
require 'kitten_counter'

Thread.abort_on_exception = true

API_ENDPOINT = URI("http://localhost:4567/register_kitten")

counter = KittenCounter.new
counter_threads = 4
kittens_in = Queue.new

threads = 1.upto(counter_threads).map { |i|
  Thread.start {
    puts "Started kitten counter #{i}"
    loop do
      kitten = kittens_in.deq.split(',')
      counter.incr
      Net::HTTP.post_form(API_ENDPOINT, { name: kitten[0], age: kitten[1], colour: kitten[2] })
    end
  }
}

while line = STDIN.gets
  kittens_in << line
end

until kittens_in.empty? && threads.all?(&:stop?)
  sleep 0.1
end
puts "Final kitten count: #{counter.total}"
puts "Shutting down..."

threads.each { |t| t.join(0.1) }
