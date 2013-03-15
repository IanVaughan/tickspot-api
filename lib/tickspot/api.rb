require 'httparty'

module Tickspot
  class Api
    include HTTParty
    format :xml

    def initialize(site, u, p) #config = nil
      @auth = {email: u, password: p}
      self.class.base_uri "https://#{site}.tickspot.com"
      # default_params :output => 'json'

      # @cache = {}
      # set_config(config) if config.nil?
      # load_config(find_config) unless config.nil?
      # @domain = config.company + "tickspot.com"
    end

    # http://tickspot.com/api/
    # The API response is wrapped within a top level XML node which normally matches the method name
    # but on some methods it differs

    # Optional : :open [true|false]
    def clients optional_params = {}
      request('clients', optional_params)['clients']
    end

    # Optional : :project_id, :open [true|false], :project_billable [true|false]
    def projects optional_params = {}
      request('projects', optional_params)['projects']
    end

    # Required : :project_id
    # Optional : :task_id, :open [true|false], :task_billable [true|false]
    def tasks required_params, optional_params = {}
      check required_params, [:project_id]
      # check optional_params, [:task_id, :open, :task_billable], false
      request('tasks', required_params.merge(optional_params))['tasks']
    end

    def clients_projects_tasks optional_params = {}
      request('clients_projects_tasks', optional_params)['clients']
    end

    # Required : :start_date, :end_date OR :updated_at
    # Optional : :project_id, :task_id, :user_id, :user_email, :client_id, :entry_billable [true|false], :billed [true|false]
    def entries required_params, optional_params = {}
      check required_params, [:start_date, :end_date]
      # updated_at
      request('entries', required_params.merge(optional_params))['entries']
    end

    def recent_tasks optional_params = {}
      request('recent_tasks', optional_params)['tasks']
    end

    # Optional : :project_id
    def users optional_params = {}
      request('users', optional_params)['users']
    end

    # Required : :task_id, :hours, :date
    # Optional : :notes
    def create_entry required_params, optional_params = {}
      check required_params, [:task_id, :hours, :date]
      request('entry', required_params.merge(optional_params))['entry']
    end

    # Required : :id
    # Optional : :hours, :date, :billed, :task_id, :user_id, :notes
    def update_entry required_params, optional_params = {}
      check required_params, [:id]
      request('create_entry', required_params.merge(optional_params))['entry']
    end

  # private

    def request method, params
      self.class.post("/api/#{method}", :query => @auth.merge(params))
    end

    def check hash, keys
      #, optional = false
      expecting = "expecting one of '#{keys}'"
      raise "Must be a hash, #{expecting}" unless hash.is_a? Hash
      keys.each do |key|
        msg = "Required parameter missing : #{key}, #{expecting}"
        raise msg unless hash.has_key?(key)
        #and optional
        return unless hash.has_key?(key)
        #and optional
      end
      true
    end
  end
end
