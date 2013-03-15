# This hits all the tickspot-api end points and saves the results into yml fixture files

require './lib/tickspot_api'
TS = Tickspot::Api.new 'electricvisions', 'tickspot@ianvaughan.co.uk', 'password'

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
