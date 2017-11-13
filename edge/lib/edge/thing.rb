module Edge
  class Thing
    attr_reader :key, :name, :description, :bi_directional
    
    def initialize(key, name, description, bi_directional = false)
      @key = key
      @name = name
      @description = description
      @bi_directional = bi_directional
    end
  end
end

