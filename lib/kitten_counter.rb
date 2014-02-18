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
