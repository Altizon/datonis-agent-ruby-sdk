module Edge
  PROTOCOL_HTTP = :http
  PROTOCOL_MQTT = :mqtt
  
  class EdgeConfiguration
    attr_reader :access_key, :secret_key, :url
    
    def initialize(access_key, secret_key, protocol = PROTOCOL_HTTP, ssl = false, url = nil)
      @access_key = access_key
      @secret_key = secret_key
      
      if (url.nil?)
        if (protocol == :http)
          @url = (ssl ? "https://api.datonis.io" : "http://api.datonis.io")
        else
          @url = (ssl ? "ssl://mqtt.datonis.io:8883" : "tcp://mqtt.datonis.io:1883")
        end
      else
        @url = url
      end
    end
  end
end
