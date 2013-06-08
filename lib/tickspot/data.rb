$LOAD_PATH << 'lib/tickspot'

require 'client'

module Tickspot
  class Data

    def initialize config
      @config = config
    end

    def api
      @api ||= Api.new @config[:company], @config[:email], @config[:password]
    end

    def clients_projects_tasks
      @clients_projects_tasks ||= api.clients_projects_tasks
    end

    def clients
      clients = []
      clients_projects_tasks.each do |client_data|
        client = Client.new(client_data)
        clients << client
        yield client if block_given?
      end
      clients
    end
  end
end

