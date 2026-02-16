require_relative 'runtime'

module Pulumi 
  class Resource 
    attr_reader :urn

    def initialize(type, name, custom: false, parent: nil, props: {}, opts: {})
      monitor = Runtime.monitor 
      raise 'Monitor not initialized' unless monitor

      response = monitor.register_resource(
        Pulumirpc::RegisterResourceRequest.new(
          type: type,
          name: name,
          custom: custom,
          parent: parent&.urn.to_s
        )
      )

      @urn = response.urn
    end
  end
end

