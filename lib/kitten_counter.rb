class KittenCounter
  attr_reader :totals, :mutex, :print_freq

  def initialize(print_freq = 10)
    @totals     = Hash.new { |h, k| h[k] = 0 }
    @mutex      = Mutex.new
    @print_freq = print_freq
  end

  def total
    @totals.inject(0) { |a, (_, v)| a + v }
  end

  def add(kitten)
    mutex.synchronize do
      @totals[kitten.colour] += 1
    end
    print_if_necessary
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

  def kittens_per_second
    if @last_check
      diff = total - @last_check.last
      now = Time.now.to_i
      t = now - @last_check.first
      (diff.to_f / t).round(2)
    else
      @last_check = [Time.now.to_i, total]
      0
    end
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
