x = 5

fred = Thread.new do
  Thread.stop
  x ** 5
end

sleep 1

fred.stop? # => true
fred.wakeup

fred.value # => 3125
