module Tickspot
  class Client
    def initialize data
      @data = data
    end

    def id
      @data[:id] || @data['id']
    end

    def name
      @data[:name] || @data['name']
    end

    def projects
      projects = []
      @data.each do |project_data|
        project = Project.new(project_data)
        projects << project
         yield project if block_given?
        end
      projects #unless block_given?
    end
  end
end
