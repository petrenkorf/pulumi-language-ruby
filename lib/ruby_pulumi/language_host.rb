require 'grpc'
require_relative 'generated/pulumi/language_pb'
require_relative 'generated/pulumi/language_services_pb'

require_relative 'generated/pulumi/resource_pb'
require_relative 'generated/pulumi/resource_services_pb'

require_relative 'pulumi'

module RubyPulumi
  class LanguageHost < Pulumirpc::LanguageRuntime::Service 

    def get_required_plugins(req, _call)
      Pulumirpc::GetRequiredPluginsResponse.new
    end

    def get_plugin_info(_req, _call)
      Pulumirpc::PluginInfo.new(
        version: "0.0.1"
      )
    end

    def run(req, _call)
      begin 
        monitor = Pulumirpc::ResourceMonitor::Stub.new(
          req.monitor_address,
          :this_channel_is_insecure
        )

        ::Pulumi::Runtime.monitor = monitor

        Dir.chdir(req.pwd) do
          Dir.glob("*.rb").sort.each do |file|
            load file
          end
        end

        Pulumirpc::RunResponse.new(error: "")
      rescue => e
        Pulumirpc::RunResponse.new(
          error: "#{e.class}: #{e.message}\n#{e.backtrace.join("\n")}"
        )
      end
    end
  end
end
