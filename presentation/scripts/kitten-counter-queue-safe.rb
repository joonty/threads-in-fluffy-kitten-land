require 'thread'

kittens = Queue.new
total_kittens.times do
  kittens << :kitten
end

1.upto(4).map {
  Thread.new {
    #...
    kittens.pop
    # ...
  }
}
