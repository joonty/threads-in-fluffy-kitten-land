fred = Thread.new { sleep 5 }

fred.status # => "run"
fred.stop? # => false
fred.alive? # => true
fred.status # => "sleep"
fred.backtrace # => ["-:1:in `sleep'", "-:1:in `block in <main>'"]

fred.join

fred.alive? # => false
fred.stop? # => true
