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

    context 'a Client object' do

      it 'should return an array of Clients' do
        # input = [{'name'=>'foo', 'id'=>1}, {'name'=>'bar', 'id'=>2}] #['foo', 'bar']
        test_data = fixture 'clients_projects_tasks'
        test_client = Client.new test_data
        Api.any_instance.stub(:clients_projects_tasks).and_return(test_data) # stub out real API call
        Client.should_receive(:new).with(test_data.first).and_return(test_client)

        @data.clients.should eq [test_client]
      end

      it 'should yield each Client' do
        # input = [{'name'=>'foo', 'id'=>1}, {'name'=>'bar', 'id'=>2}]  #['foo', 'bar']
        test_data = fixture 'clients_projects_tasks'
        test_client = Client.new test_data
        Api.any_instance.stub(:clients_projects_tasks).and_return(test_client)

        @data.should_receive(:clients).and_yield test_client
        @data.clients { |c| }
      end

      it 'should return an array of projects' do
        # test_data = fixture 'clients_projects_tasks'
        # test_project = test_data[:projects]
        # @data.clients.first.should eq [test_project]
      end

    end
  end
end
