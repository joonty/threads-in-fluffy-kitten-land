require 'net/http'
require 'thread'
require 'benchmark'
Thread.abort_on_exception = true

API_ENDPOINT = URI("http://localhost:4567/register_kitten")

class KittenCounter
  attr_reader :total

  def initialize
    @total = 0
  end

  def incr
    @total += 1
    if @total % 10 == 0
      puts "Total kittens: #{total}"
    end
  end
end

counter = KittenCounter.new
counter_threads = 1
kittens_in = Queue.new

puts Benchmark.measure {
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

  threads.each { |t| t.join 1 }
  puts "Final kitten count: #{counter.total}"
}
