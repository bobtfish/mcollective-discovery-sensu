require 'mcollective/rpc/helpers'

module MCollective
  class Discovery
    class Sensu
      def self.discover(filter, timeout, limit=0, client=nil)
        host = config.pluginconf["discovery.sensu.host"] || 'localhost'
        port = config.pluginconf["discovery.sensu.port"] || 4567
        uri = "http://#{host}:#{port}/clients"
        data = []
        discovered = []
        begin
          body = Net::HTTP.get(URI(uri))
          data = JSON.parse(body)
        rescue Exception => e
          raise("Could not get #{uri}, returned JSON #{body}, exception #{e}")
        end
        data.each { |node| discovered << node['name'] }
        discovered
      end
    end
  end
end

