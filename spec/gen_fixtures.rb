TS = Tickspot::Api.new 'company', 'email', 'password'
require './lib/tickspot_api'

def save name
  File.open("spec/fixtures/#{name}.yml", 'w') do |f|
    yield f
  end
end

def access method
  puts "#{method}"
  save method do |f|
    YAML.dump TS.send(method), f
  end
end

%w{clients users projects clients_projects_tasks recent_tasks}.each do |m|
  access m
end

# ts.tasks
# ts.entries
