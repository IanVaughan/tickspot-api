$LOAD_PATH << 'lib/tickspot'

require 'client'
require 'task'

module Tickspot
  class Data

    def initialize config
      # @data = parsed
      # raise unless parsed.class == Hash
      # @data = parsed#[parsed.keys.first]
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

    # def id
    #   self.method_missing(:id)
    # end
    # def empty?
    #   if @hash["type"] == "array" && @hash["content"] == "\n"
    #     true
    #   else
    #     false
    #   end
    # end
    # def method_missing(method, *args)
    #   puts "->#{method}, #{args}"
    #   return Data.new(@data[args.first]) if @data.class == Array
    #   if @data.has_key?(method.to_s)
    #     entry = @data[method.to_s]
    #     # return entry[0] unless entry[0].class == Hash && entry[0].has_key?("content")
    #     # return entry[0]["content"]
    #     # entry = Data.new(entry) if entry.class == Hash
    #     entry
    #   else
    #     super
    #   end
    # end

  end
end

__END__

require 'yaml'
require 'tickspot_api'

module TickIt
  class Api
    def initialize *config
      @ts = Tickspot::Api.new *config
      # @ts = init config
    end

    def projects search
      @ts.projects['projects'].each do |p|
        puts "[#{p['id']}] #{p['name']}"
      end
    end

    def project name
      puts projects['projects'][1]
      puts "project : #{name}"
    end

    def self.find_config filename
      dir = nil
      pwd = Dir.pwd
      while !File.exists? filename and Dir.pwd != '/' do
        Dir.chdir '..'
      end
      dir = Dir.pwd if File.exists? filename
      Dir.chdir pwd
      puts dir
      dir
    end

    def my_clients_names
      clients = []
      Api.clients.each do |c|
        clients << c['name']
      end
      client
    end

    def my_clients_projects client
      projects
    end

  end
end

# TickIt::Api.find_config '.tickconfig'
