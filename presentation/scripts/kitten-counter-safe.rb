require 'thread'

class KittenCounter
  attr_reader :total

  def initialize
    @total = 0
    @mutex = Mutex.new
  end

  def incr
    @mutex.synchronize do
      @total += 1
    end
  end
end
