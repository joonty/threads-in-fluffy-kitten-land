class KittenCounter
  attr_reader :total

  def initialize
    @total = 0
  end

  def incr
    @total += 1
  end
end
