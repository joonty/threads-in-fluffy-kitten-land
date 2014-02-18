kittens = Array.new(total_kittens, :kitten)

1.upto(4).map {
  Thread.new {
    #...
    kittens.pop # HERE
    # ...
  }
}
