class KittenGateway
  attr_reader :endpoint

  def initialize(endpoint)
    @endpoint = endpoint
  end

  def dispatch(kitten)
    # kitten.to_h => { name: "Timmy", age: "3", colour: "White" }
    Net::HTTP.post_form(@endpoint, kitten.to_h)
  end
end
