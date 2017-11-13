require 'net/http'
require 'net/https'
require 'uri'
require 'edge/edge_util'
require 'json'


module Edge
  class EdgeGatewayHttp
    def initialize(config)
      @config = config
      @http = init_http_stub
    end
    
    def init_http_stub
      uri = URI(@config.url)
      http = Net::HTTP.new(uri.host, uri.port)
      if uri.scheme == "https"
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      return http
    end
    
    def encrypt_and_send_data(uri, json)
      hash = calculate_hmac_sha256(@config.secret_key, json)
      handle_response(@http.post(uri, json, {"X-Access-Key" => @config.access_key, "X-Dtn-Signature" => hash}))
    end
    
    def handle_response(response)
      body = response.body.to_s.strip
      puts "Response code: #{response.code.to_i}"
      if (response.code.to_i != 200) && !body.empty?
        parsed = JSON.parse(body)
        if parsed.kind_of? Array
          error_msgs = parsed
        else  
          error_msgs = parsed["errors"]
        end
        error_msgs.each do |em|
          puts "Error #{em["code"]} : #{em["message"]}"
        end  
      end
      map_http_code(response.code)
    end
    
    def register(thing)
      uri  = register_url
      json = thing_register_json(thing)
      puts "Registering with: #{json}"
      encrypt_and_send_data(uri, json)
    end
    
    def send_heart_beat(thing)
      uri = heart_beat_url
      json = thing_heart_beat_json(thing)
      puts "Sending Heart Beat: #{json}"
      encrypt_and_send_data(uri, json)
    end
    
    def send_data(thing, data, waypoint = nil, timestamp = nil)
      uri = event_url
      json = thing_data_json(thing, data, waypoint, timestamp)
      puts "Sending Data: #{json}"
      encrypt_and_send_data(uri, json)
    end

    def send_bulk_data(thing,data)
      uri = event_url
      json = thing_data_json(thing,data,nil,nil)
      puts "Sending Bulk Data: #{json}"
      encrypt_and_send_data(uri,json)
    end
    
    def send_alert(thing, alert_msg, alert_level = 0, alert_data = {}, ts = nil)
      uri = alert_url
      json = thing_alert_json(thing, alert_msg, alert_level, alert_data, ts)
      puts "Sending Alert: #{json}"
      encrypt_and_send_data(uri, json)
    end
  end 
end
