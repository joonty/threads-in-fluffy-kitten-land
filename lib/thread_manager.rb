class ThreadManager
  attr_reader :num_threads, :gateway, :counter, :threads

  def initialize(num_threads, gateway, counter)
    @num_threads = num_threads
    @gateway     = gateway
    @counter     = counter
    @threads     = []
  end

  def start(kitten_queue)
    @threads = 1.upto(num_threads).map { |i|
      Thread.start { thread_exec(i, kitten_queue) }
    }
  end

  def all_inactive?
    threads.all?(&:stop?)
  end

  def stop
    threads.each { |t| t.join(0.1) }
  end

protected
  def thread_exec(thread_id, kitten_queue)
    puts "Started kitten counter #{thread_id}"
    loop do
      split_kitten = kitten_queue.deq.split(',').map(&:strip)
      kitten = Kitten.new(*split_kitten)
      counter.add(kitten)
      gateway.dispatch(kitten)
    end
  end
end
