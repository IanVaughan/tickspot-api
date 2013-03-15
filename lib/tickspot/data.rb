$LOAD_PATH << 'lib/tickspot'

require 'client'
require 'task'

module Tickspot
  class Data

    def initialize config
      @config = config
    end

    def api
      @api ||= Api.new @config[:company], @config[:email], @config[:password]
    end

    def clients
      clients = []
      api.clients_projects_tasks.each do |client_data|
        client = Client.new(client_data)
        clients << client
         yield client if block_given?
        end
      clients #unless block_given?
    end

  end
end

