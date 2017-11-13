require 'json'
require 'edge/edge_code'

def get_ts()
  return Time.now.to_i*1000
end

def calculate_hmac_sha256(access_key, data)
  if RUBY_VERSION < "2.1.0"
    require 'digest/hmac'
    Digest::HMAC.hexdigest(data, access_key, Digest::SHA2)
  else
    digest = OpenSSL::Digest.new('sha256')
    hmac = OpenSSL::HMAC.hexdigest(digest, access_key, data)
  end
end

def current_timestamp_millis
  Time.now.to_i * 1000
end

def register_url(base_url=nil)
  url = "/api/v3/things/register.json"
  url = base_url + url if !base_url.nil?
  return url
end

def event_url(base_url=nil)
  url = "/api/v3/things/event.json"
  url = base_url + url if !base_url.nil?
  return url
end

def alert_url(base_url=nil)
  url = "/api/v3/alerts.json"
  url = base_url + url if !base_url.nil?
  return url
end

def heart_beat_url(base_url=nil)
  url = "/api/v3/things/heartbeat.json"
  url = base_url + url if !base_url.nil?
  return url
end

def basic_hash(timestamp = nil)
  {:timestamp => (timestamp || current_timestamp_millis)}
end

def thing_register_json(thing)
  basic_hash.merge({:thing_key => thing.key, :name => thing.name, :description => thing.description, :bi_directional => thing.bi_directional}).to_json
end

def thing_alert_json(thing, alert_msg, alert_level = 0, alert_data = {}, timestamp = nil)
  h = basic_hash(timestamp).merge({:thing_key => thing.key, :alert_type => alert_level, :message => alert_msg, :data => alert_data})
  {:alert => h}.to_json
end

def thing_heart_beat_json(thing)
  basic_hash.merge({:thing_key => thing.key}).to_json
end

def thing_data_hash(thing, data, waypoint = nil, timestamp = nil)
  h = basic_hash(timestamp).merge({:thing_key => thing.key})
  h.merge!({:data => data}) if !data.nil?
  h.merge!({:waypoint => waypoint}) if !waypoint.nil?
  h
end

def thing_data_json(thing, data, waypoint = nil, timestamp = nil)
  if (data.kind_of?(Array))
    basic_hash.merge(:events => data).to_json
  else
    thing_data_hash(thing, data, waypoint, timestamp).to_json
  end
end

def map_http_code(code)
  case code.to_i
  when 200, 202
    Edge::EdgeCode::OK
  when 401
    Edge::EdgeCode::UNAUTHORIZED
  when 406
    Edge::EdgeCode::NOT_ACCEPTABLE
  when 422
    Edge::EdgeCode::INVALID_REQUEST
  when 429
    Edge::EdgeCode::EXCESSIVE_RATE
  else
    Edge::EdgeCode::FAILED
  end
end