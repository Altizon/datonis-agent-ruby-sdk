module Edge
  class EdgeCode
    attr_reader :key, :value
    
    def initialize(key, value)
       @key = key
       @value = value
    end
    
    def code
      value[:code]
    end
    
    def message
      value[:message]
    end
    
    class << self
      def define(key, value)
        @hash ||= {}
        @hash[key] = self.new(key, value)
      end
     
      def const_missing(key)
        @hash[key]
      end
     
      def each
        @hash.each do |key, value|
          yield key, value
        end
      end
     
      def all
        @hash.values
      end
     
      def all_to_hash
        hash = {}
        each do |key, value|
          hash[key] = value.value
        end
        hash
      end
    end    
  end
  
  EdgeCode.define :INVALID_PARAMS, {:code => -1, :message => "Parameters specified with the request are invalid"}
  EdgeCode.define :OK, {:code => 0, :message => "Request was processed successfully"}
  EdgeCode.define :UNAUTHORIZED, {:code => 1, :message => "Unauthorized access. Please check your access and secret key"}
  EdgeCode.define :INVALID_REQUEST, {:code => 2, :message => "Request is invalid"} 
  EdgeCode.define :EXCESSIVE_RATE, {:code => 3, :message => "You are pushing data at a rate that is greater than what your license allows"}
  EdgeCode.define :FAILED, {:code => 4, :message => "Failed to send data. Reasons are unknown"}
  EdgeCode.define :NOT_ACCEPTABLE, {:code => 5, :message => "Failed to send data. Request is unacceptable"}
  EdgeCode.define :NO_CONNECTION, {:code => 6, :message => "Not connected"}
end
