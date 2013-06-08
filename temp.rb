require 'yaml'
require 'tickspot_api'

module TickIt
  class Api
    def initialize *config
      @ts = Tickspot::Api.new *config
      # @ts = init config
    end

    def projects #search
      @ts.projects['projects'].each do |p|
        puts "[#{p['id']}] #{p['name']}"
      end
    end

    def my_clients_names
      Api.clients.map { |c| c['name'] }
    end
  end
end

# $LOAD_PATH.unshift(File.dirname(__FILE__))
# $LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

# require File.dirname(__FILE__) + '/tickspot_entry'
# require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

ts = Tickspot::Api.new('electricvisions', 'tickspot@ianvaughan.co.uk', 'password')
ts = Tickspot::Api.new('globalpersonals', 'ivaughan@globalpersonals.co.uk', 'password')

# ts['projects'].first['name']
# => "TestClient-TestProject"

# pro = ts.clients_projects_tasks
# puts ts.projects
# puts pro[0]
# puts pro[0]['id']


ts.clients
=> [{"id"=>128542, "name"=>"TestClient2"}]
ts.projects
=> [{"id"=>408314, "name"=>"TestClient-TestProject", "budget"=>100.0, "client_id"=>128542, "owner_id"=>86580, "opened_on"=>#<Date: 2012-05-14 ((2456062j,0s,0n),+0s,2299161j)>, "closed_on"=>nil, "created_at"=>2012-05-14 06:44:46 UTC, "updated_at"=>2012-05-14 06:49:57 UTC, "client_name"=>"TestClient2", "sum_hours"=>0.0, "user_count"=>0, "tasks"=>[{"id"=>2162941, "name"=>"TestClient-TestProject-TestTask1", "position"=>1, "project_id"=>408314, "opened_on"=>#<Date: 2012-05-14 ((2456062j,0s,0n),+0s,2299161j)>, "closed_on"=>nil, "budget"=>10.0, "billable"=>true, "sum_hours"=>0.0, "user_count"=>0}, {"id"=>2162942, "name"=>"TestClient-TestProject-TestTask2", "position"=>2, "project_id"=>408314, "opened_on"=>#<Date: 2012-05-14 ((2456062j,0s,0n),+0s,2299161j)>, "closed_on"=>nil, "budget"=>90.0, "billable"=>true, "sum_hours"=>0.0, "user_count"=>0}, {"id"=>2162943, "name"=>"TestClient-TestProject-TestTask3", "position"=>3, "project_id"=>408314, "opened_on"=>#<Date: 2012-05-14 ((2456062j,0s,0n),+0s,2299161j)>, "closed_on"=>nil, "budget"=>0.0, "billable"=>true, "sum_hours"=>0.0, "user_count"=>0}]}]
ts.clients_projects_tasks
=> [{"id"=>128542, "name"=>"TestClient2", "projects"=>[{"id"=>408314, "name"=>"TestClient-TestProject", "budget"=>100.0, "client_id"=>128542, "opened_on"=>#<Date: 2012-05-14 ((2456062j,0s,0n),+0s,2299161j)>, "closed_on"=>nil, "created_at"=>2012-05-14 06:44:46 UTC, "updated_at"=>2012-05-14 06:49:57 UTC, "tasks"=>[{"id"=>2162941, "name"=>"TestClient-TestProject-TestTask1", "position"=>1, "project_id"=>408314, "opened_on"=>#<Date: 2012-05-14 ((2456062j,0s,0n),+0s,2299161j)>, "closed_on"=>nil, "budget"=>10.0, "billable"=>nil}, {"id"=>2162942, "name"=>"TestClient-TestProject-TestTask2", "position"=>2, "project_id"=>408314, "opened_on"=>#<Date: 2012-05-14 ((2456062j,0s,0n),+0s,2299161j)>, "closed_on"=>nil, "budget"=>90.0, "billable"=>nil}, {"id"=>2162943, "name"=>"TestClient-TestProject-TestTask3", "position"=>3, "project_id"=>408314, "opened_on"=>#<Date: 2012-05-14 ((2456062j,0s,0n),+0s,2299161j)>, "closed_on"=>nil, "budget"=>0.0, "billable"=>nil}]}]}]
ts.users
=> [{"id"=>86580, "first_name"=>"Ian", "last_name"=>"Vaughan", "email"=>"tickspot@ianvaughan.co.uk", "created_at"=>2012-05-14 06:41:23 UTC, "updated_at"=>2012-05-14 06:43:06 UTC}, {"id"=>86583, "first_name"=>"TickSpotTestUser-FirstName", "last_name"=>"TickSpotTestUser-LastName", "email"=>"tickspot-test@ianvaughan.co.uk", "created_at"=>2012-05-14 06:51:24 UTC, "updated_at"=>2012-05-14 06:57:57 UTC}]

id = {project_id: 408314}
=> {:project_id=>408314}
ts.tasks(id)
=> [{"id"=>2162941, "name"=>"TestClient-TestProject-TestTask1", "position"=>1, "project_id"=>408314, "opened_on"=>#<Date: 2012-05-14 ((2456062j,0s,0n),+0s,2299161j)>, "closed_on"=>nil, "budget"=>10.0, "billable"=>true}, {"id"=>2162942, "name"=>"TestClient-TestProject-TestTask2", "position"=>2, "project_id"=>408314, "opened_on"=>#<Date: 2012-05-14 ((2456062j,0s,0n),+0s,2299161j)>, "closed_on"=>nil, "budget"=>90.0, "billable"=>true}, {"id"=>2162943, "name"=>"TestClient-TestProject-TestTask3", "position"=>3, "project_id"=>408314, "opened_on"=>#<Date: 2012-05-14 ((2456062j,0s,0n),+0s,2299161j)>, "closed_on"=>nil, "budget"=>0.0, "billable"=>true}]



require 'ostruct'
class Test < OpenStruct
  def ids
    self.marshal_dump.each {|k,v| puts "#{k} -- #{v}"}
  end
end

