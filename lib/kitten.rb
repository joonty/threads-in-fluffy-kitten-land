class Kitten < Struct.new(:name, :age, :colour)
  def to_h
    { name: name, age: age, colour: colour }
  end
end
