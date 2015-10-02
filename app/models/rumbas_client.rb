require 'savon'

class RumbasClient
  def self.test
    client = Savon::Client.new(wsdl: "http://localhost:3000/rumbas/wsdl")

    client.operations # => [:integer_to_string, :concat, :add_circle]

    result = client.call(:concat, message: { :a => "123", :b => "abc" })

    # actual wash_out
    result.to_hash # => {:concat_reponse => {:value=>"123abc"}}

    # wash_out below 0.3.0 (and this is malformed response so please update)
    result.to_hash # => {:value=>"123abc"}
  end
end