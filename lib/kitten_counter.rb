class KittenCounter
  attr_reader :totals, :mutex

  def initialize(print_freq = 10)
    @totals = Hash.new { |h, k| h[k] = 0 }
    @mutex = Mutex.new
  end

  def total
    @totals.inject(0) { |a, (_, v)| a + v }
  end

  def add(kitten)
    mutex.synchronize do
      @totals[kitten.colour] += 1
    end
  end

  def formatted_result
    <<-CAT

*******************************

 Total kittens => #{total}

 By colour:
#{formatted_colours}
*******************************

    CAT
  end

protected
  def formatted_colours
    totals.inject("") { |s, (colour, total)|
      s << "  - #{colour} => #{total}\n"
    }
  end

  def print_if_necessary
    if print_freq > 0 && total % print_freq == 0
      puts "Total kittens: #{total}"
    end
  end
end
