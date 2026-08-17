require_relative 'runtime'
require 'google/protobuf/well_known_types'

module Pulumi
  class Resource
    def initialize(type, name, custom: false, parent: nil, props: {}, opts: {})
      monitor = Runtime.monitor
      raise 'Monitor not initialized' unless monitor

      request = Pulumirpc::RegisterResourceRequest.new(
        type: type,
        name: name,
        custom: custom,
        parent: parent&.urn.to_s,
        object: Google::Protobuf::Struct.from_hash(props),
        provider: opts[:provider]&.urn.to_s.to_s
      )

      @resolver = Thread.new { monitor.register_resource(request) }
    end

    def urn
      response.urn
    end

    def id
      response.id
    end

    def outputs
      response.object.to_h
    end

    def [](key)
      outputs[key.to_s]
    end

    private

    def response
      @response ||= @resolver.value
    end
  end

  class CustomResource < Resource
    def initialize(type, name, props: {}, opts: {})
      super(type, name, custom: true, parent: opts[:parent], props: props, opts: opts)
    end
  end
end
