number = ARGV.first.to_i
unless number > 0
  abort "The first argument should be a positive number of kittens to generate"
end

names = %w(Tom Terry Alice Bob Joanna Helen Timmy Anna)
colours = %w(Grey Ginger Black White)

1.upto(number) do
  puts [names.sample, (0..4).to_a.sample, colours.sample].join(",")
end
