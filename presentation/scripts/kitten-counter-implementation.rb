require 'kitten-counter'

total_kittens = ARGV.shift.to_i

kittens = Array.new(total_kittens, :kitten)
counter = KittenCounter.new

1.upto(4).map {
  Thread.new {
    until kittens.empty?
      kittens.pop
      counter.incr
    end
  }
}.each(&:join)

puts "Counted #{counter.total} kittens"
