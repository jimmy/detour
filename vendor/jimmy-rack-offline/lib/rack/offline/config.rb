module Rack
  class Offline
    class Config
      def initialize(&block)
        @cache = []
        @network = []
        @fallback = {}
        instance_eval(&block) if block_given?
      end

      def cache(*names)
        @cache.concat(names)
      end

      def network(*names)
        @network.concat(names)
      end

      def fallback(hash = {})
        @fallback.merge!(hash)
      end
    end
  end
end
