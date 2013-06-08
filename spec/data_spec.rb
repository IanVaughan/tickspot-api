require 'spec_helper'
require './lib/tickspot_api'

module Tickspot
  describe Data do
    let(:login) { {company:'', email:'', password:'' } }
    subject { Data.new login }
    let(:test_data) { fixture 'clients_projects_tasks' }
    let(:test_client) { Client.new test_data }

    before do
      # input = [{'name'=>'foo', 'id'=>1}, {'name'=>'bar', 'id'=>2}] #['foo', 'bar']
      Api.any_instance.stub(:clients_projects_tasks).and_return(test_data) # stub out real API call
    end

    # its(:clients) { should be_kind_of Array } # Or like an Array
    its(:clients) { should respond_to :each }
    # its(:clients) { should respond_to :names }
    # its(:clients) { should respond_to :ids }

    its(:"clients.first") { should be_kind_of Client }
    its(:"clients.first") { should respond_to :name }
    its(:"clients.first") { should respond_to :id }

    its(:"clients.first.name") { should eq 'TestClient2' }
    its(:"clients.first.id") { should eq 128542 }

    # context 'returns a list of client names' do
    #   its(:"clients.names") { should eq ['TestClient2', 'TestClient3'] }
    # end

    # it 'returns an array of Clients' do
    # context "array of Clients" do
    #   before { Client.should_receive(:new).with(test_data).and_return(test_client) }
    #   it { should == [test_client] }
    #   # its(:clients) { should eq [test_client] }
    # end

    # context 'yields each Client' do
    #   it { should_receive(:clients).and_yield test_client }
    #   # @data.clients { |c| }
    # end

    # context 'projects' do
    #   let(:test_project) { test_data.first[:projects] }
    #   its(:'clients.first.projects') { should eq [test_project] }
    # end
  end
end
