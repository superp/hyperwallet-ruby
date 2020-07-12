module Hyperwallet
  class HyperwalletObject
    attr_reader :values

    def initialize(values)
      @values = {}
      (self.class.attributes + values.keys).each do |k|
        attr = Util.symbolize_attribute(k)
        @values[attr] = HyperwalletObject.convert_to_hyperwallet_object(values[k], self.class, attr)
      end
    end

    def self.convert_to_hyperwallet_object(resp, type = nil, relation = nil)
      case resp
      when Array
        resp.map { |r| convert_to_hyperwallet_object(r, type, relation) }
      when Hash
        object_class = (relation.nil? ? type : type.relations[relation]) || HyperwalletObject
        object_class.construct_from(resp)
      else
        resp
      end
    end

    def self.attributes
      []
    end

    def self.relations
      {}
    end

    def self.construct_from(values)
      object = self.new(values)
    end

    def method_missing(name, *args, &block)
      if @values.has_key?(name)
        @values[name]
      else
        super
      end
    end

    def respond_to_missing?(name, *args)
      @values.has_key?(name) || super
    end
  end
end
