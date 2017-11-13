require 'edge/thing'
require 'edge/edge_configuration'
require 'edge/edge_gateway_http'

#Edge::Thing.new(key, name, description)
t = Edge::Thing.new("385728d6cf", "Compressor", "An example compressor thing")
#Edge::EdgeConfiguration.new(access_key, secrete_key, protocol = "http", ssl = false, url=nil)
c = Edge::EdgeConfiguration.new("1d2fb5c369863fd54afafde654c26dtd51122t8e", "f4e31122629etaeaa48d9c8c72b8cctfc9d63acc")
#initialize the gateway
g = Edge::EdgeGatewayHttp.new(c)
#register the thing
g.register(t)

counter = 0
while true
  if counter == 0
    # Send heart beat in between (optional)
    g.send_heart_beat(t)
  end
  data = {:temperature => rand(40..80), :pressure => rand(1..10)}
  # waypoint format : [latitude, longitude], uncomment below line when sending waypoints.
  # waypoint = [(18.52 + rand/10), (73.85 + rand/10)];
  timestamp = Time.now.to_i * 1000;
  # we can send the data in three ways
  g.send_data(t, data, nil, timestamp) #1. send only data
  # g.send_data(t, nil, waypoint, timestamp) #2. send only waypoint
  # g.send_data(t, data, waypoint, timestamp) #3. send both data and waypoint
  
  counter = (counter + 1) % 5
  sleep(5)
end