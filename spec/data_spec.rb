require 'spec_helper'
require './lib/tickspot_api'
# require 'tick-it/api/api'

module Tickspot
  describe Data do
    # let(:ts) { double ('Tickspot::Api') }
    # let(:api) { Api.new '','','' }

    before do
      h = {company:'', email:'', password:'' }
      @data = Data.new h
    end

    context 'Data should return Client objects' do

      before do
        # input = [{'name'=>'foo', 'id'=>1}, {'name'=>'bar', 'id'=>2}] #['foo', 'bar']
        test_data = fixture 'clients_projects_tasks'
        test_client = Client.new test_data
        Api.any_instance.stub(:clients_projects_tasks).and_return(test_data) # stub out real API call
        # Api.any_instance.stub(:clients_projects_tasks).and_return(test_client)
      end

      it 'should return a client names' do
        @data.clients.names.should eq ['TestClient2', 'TestClient3']
        @data.clients.first.name.should eq 'TestClient2'
      end

      it 'should return a client IDs' do
        @data.clients.ids.should eq [128542, 888]
        @data.clients.first.id.should eq 128542
      end

      it 'should return an array of Clients' do
        Client.should_receive(:new).with(test_data.first).and_return(test_client)
        @data.clients.should eq [test_client]
      end

      it 'should yield each Client' do
        @data.should_receive(:clients).and_yield test_client
        @data.clients { |c| }
      end

      it 'should return an array of projects' do
        test_data = fixture 'clients_projects_tasks'
        test_project = test_data.first[:projects]

        test_client = Client.new test_data
        Api.any_instance.stub(:clients_projects_tasks).and_return(test_data)

        @data.clients.first.projects.should eq [test_project]
      end

    end
  end
end
