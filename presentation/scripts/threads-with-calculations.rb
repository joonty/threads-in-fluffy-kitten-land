require 'benchmark'
num_threads = ARGV.shift.to_i

def fib(n)
  if n < 3
    1
  else
    fib(n-1) + fib(n-2)
  end
end

1.upto(num_threads).map { |i|
  Thread.new { puts fib(34) }
}.each(&:join)
