require 'spec_helper'
require './lib/tickspot_api'

module Tickspot
  describe Api do

    context 'init' do
      # it 'should init the object data' do
      #   # Api.expects.base_uri = "https://company.tickspot.com"
      #   # Api.expects.auth = {email: u, password: p}
    end

    context 'helpers' do
      subject { Api.new '', '', '' }
      it { subject.check({:id => 1, :name => 'foo'}, [:id]).should be_true }
      it { subject.check({:id => 1, :name => 'foo'}, [:id, :name]).should be_true }
      it { subject.check({:id => 1, :name => 'foo', :foo => 'bar'}, [:id, :name]).should be_true }

      # context 'not sure how to its it' do
      #   before do
      #     @ts = Api.new '', '', ''
      #   end

      #   expect {
      #     @ts.check({:id => 1, :name => 'foo'}, [:id, :name, :foo])
      #   }.should raise_error
      # end
    end

    context 'requests' do
      before do
        @c = 'company'
        @u = 'user@email.com'
        @p = 'password'
        @ts = Api.new @c, @u, @p
      end

      it 'should request tickspot' do
        # request = "https://#{@c}.tickspot.com/api/clients?email=#{@u}&password=#{@p}"
        # request = "https://company.tickspot.com/api/clients?email=user%40email.com&password=password"
        request = %r{https://company.tickspot.com/api/clients}
        expected_response = File.join(File.dirname(__FILE__), 'fixtures', 'clients.xml')
        FakeWeb.register_uri(:post, request, :response => expected_response) # body: 'hi')

        result = {"clients"=>[{"id"=>128542, "name"=>"TestClient2"}]}
        @ts.request('clients', {}).should eq result
      end

      it 'should do a post request with the parameters' do
        # HTTParty.any_instance.
        Api.should_receive(:post).with(
          # https://#{@c}.tickspot.com
          "/api/test",
          :query => {
            :email => @u,
            :password => @p
          }
        ).and_return()#@result)

        @ts.request('test', {})
      end

      it 'should pass every argument in the query hash' do
        Api.should_receive(:post).with(
          '/api/test',
          :query => {
            :email => @u,
            :password => @p,
            :woo => 'bleh'
          }
        ).and_return(@result)

        @ts.request('test', :woo => 'bleh')
      end

      it 'should strip the top level node' do
        # HTTParty
        Api.stub!(:post).and_return(@result)

        @ts.request('test', {}).should == []
      end
    end

    context 'methods' do
      before do
        @ts = Api.new 'company', 'user@email.com', 'password'
      end

      it 'should get clients' do
        data = {'clients' => [{ 'id' => 128542, 'name' => 'TestClient2' }] }
        @ts.stub(:request).and_return(data)

        @ts.clients.should eq data['clients']
      end

      it 'should get clients with options' do
        h = {'clients' => [{ 'id' => 128542, 'name' => 'TestClient2' }] }
        # should_recive {:open => true}
        @ts.stub(:request).and_return(h)

        @ts.clients('open').should eq h['clients']
      end

      it 'should get clients_projects_tasks' do
        # h = {"clients"=>[{"id"=>128542, "name"=>"TestClient2", "projects"=>[{"id"=>408314, "name"=>"TestClient-TestProject", "budget"=>100.0, "client_id"=>128542, "opened_on"=>#<Date: 2012-05-14 ((2456062j,0s,0n),+0s,2299161j)>, "closed_on"=>nil, "created_at"=>2012-05-14 06:44:46 UTC, "updated_at"=>2012-05-14 06:49:57 UTC, "tasks"=>[{"id"=>2162941, "name"=>"TestClient-TestProject-TestTask1", "position"=>1, "project_id"=>408314, "opened_on"=>#<Date: 2012-05-14 ((2456062j,0s,0n),+0s,2299161j)>, "closed_on"=>nil, "budget"=>10.0, "billable"=>nil}, {"id"=>2162942, "name"=>"TestClient-TestProject-TestTask2", "position"=>2, "project_id"=>408314, "opened_on"=>#<Date: 2012-05-14 ((2456062j,0s,0n),+0s,2299161j)>, "closed_on"=>nil, "budget"=>90.0, "billable"=>nil}, {"id"=>2162943, "name"=>"TestClient-TestProject-TestTask3", "position"=>3, "project_id"=>408314, "opened_on"=>#<Date: 2012-05-14 ((2456062j,0s,0n),+0s,2299161j)>, "closed_on"=>nil, "budget"=>0.0, "billable"=>nil}]}]}]}
        h = {"clients"=>[{"id"=>128542, "name"=>"TestClient2", "projects"=>[{"id"=>408314, "name"=>"TestClient-TestProject", "budget"=>100.0, "client_id"=>128542, "opened_on"=>0, "closed_on"=>nil, "created_at"=>0, "updated_at"=>0, "tasks"=>[{"id"=>2162941, "name"=>"TestClient-TestProject-TestTask1", "position"=>1, "project_id"=>408314, "opened_on"=>0, "closed_on"=>nil, "budget"=>10.0, "billable"=>nil}, {"id"=>2162942, "name"=>"TestClient-TestProject-TestTask2", "position"=>2, "project_id"=>408314, "opened_on"=>0, "closed_on"=>nil, "budget"=>90.0, "billable"=>nil}, {"id"=>2162943, "name"=>"TestClient-TestProject-TestTask3", "position"=>3, "project_id"=>408314, "opened_on"=>0, "closed_on"=>nil, "budget"=>0.0, "billable"=>nil}]}]}]}
        @ts.stub(:request).and_return(h)

        @ts.clients_projects_tasks.should eq h['clients']
      end

      it 'should get projects' do
        # h = {"projects"=>[{"id"=>408314, "name"=>"TestClient-TestProject", "budget"=>100.0, "client_id"=>128542, "owner_id"=>86580, "opened_on"=>#<Date: 2012-05-14 ((2456062j,0s,0n),+0s,2299161j)>, "closed_on"=>nil, "created_at"=>2012-05-14 06:44:46 UTC, "updated_at"=>2012-05-14 06:49:57 UTC, "client_name"=>"TestClient2", "sum_hours"=>0.0, "user_count"=>0, "tasks"=>[{"id"=>2162941, "name"=>"TestClient-TestProject-TestTask1", "position"=>1, "project_id"=>408314, "opened_on"=>#<Date: 2012-05-14 ((2456062j,0s,0n),+0s,2299161j)>, "closed_on"=>nil, "budget"=>10.0, "billable"=>true, "sum_hours"=>0.0, "user_count"=>0}, {"id"=>2162942, "name"=>"TestClient-TestProject-TestTask2", "position"=>2, "project_id"=>408314, "opened_on"=>#<Date: 2012-05-14 ((2456062j,0s,0n),+0s,2299161j)>, "closed_on"=>nil, "budget"=>90.0, "billable"=>true, "sum_hours"=>0.0, "user_count"=>0}, {"id"=>2162943, "name"=>"TestClient-TestProject-TestTask3", "position"=>3, "project_id"=>408314, "opened_on"=>#<Date: 2012-05-14 ((2456062j,0s,0n),+0s,2299161j)>, "closed_on"=>nil, "budget"=>0.0, "billable"=>true, "sum_hours"=>0.0, "user_count"=>0}]}]}
        h = {"projects"=>[{"id"=>408314, "name"=>"TestClient-TestProject", "budget"=>100.0, "client_id"=>128542, "owner_id"=>86580, "opened_on"=>0, "closed_on"=>nil, "created_at"=>1, "updated_at"=>1, "client_name"=>"TestClient2", "sum_hours"=>0.0, "user_count"=>0, "tasks"=>[{"id"=>2162941, "name"=>"TestClient-TestProject-TestTask1", "position"=>1, "project_id"=>408314, "opened_on"=>1, "closed_on"=>nil, "budget"=>10.0, "billable"=>true, "sum_hours"=>0.0, "user_count"=>0}, {"id"=>2162942, "name"=>"TestClient-TestProject-TestTask2", "position"=>2, "project_id"=>408314, "opened_on"=>2, "closed_on"=>nil, "budget"=>90.0, "billable"=>true, "sum_hours"=>0.0, "user_count"=>0}, {"id"=>2162943, "name"=>"TestClient-TestProject-TestTask3", "position"=>3, "project_id"=>408314, "opened_on"=>1, "closed_on"=>nil, "budget"=>0.0, "billable"=>true, "sum_hours"=>0.0, "user_count"=>0}]}]}
        @ts.stub(:request).and_return(h)

        @ts.projects.should eq h['projects']
      end

      it 'should get tasks' do
        # h = {"tasks"=>[{"id"=>2162941, "name"=>"TestClient-TestProject-TestTask1", "position"=>1, "project_id"=>408314, "opened_on"=>#<Date: 2012-05-14 ((2456062j,0s,0n),+0s,2299161j)>, "closed_on"=>nil, "budget"=>10.0, "billable"=>true}, {"id"=>2162942, "name"=>"TestClient-TestProject-TestTask2", "position"=>2, "project_id"=>408314, "opened_on"=>#<Date: 2012-05-14 ((2456062j,0s,0n),+0s,2299161j)>, "closed_on"=>nil, "budget"=>90.0, "billable"=>true}, {"id"=>2162943, "name"=>"TestClient-TestProject-TestTask3", "position"=>3, "project_id"=>408314, "opened_on"=>#<Date: 2012-05-14 ((2456062j,0s,0n),+0s,2299161j)>, "closed_on"=>nil, "budget"=>0.0, "billable"=>true}]}
        h = {"tasks"=>[{"id"=>2162941, "name"=>"TestClient-TestProject-TestTask1", "position"=>1, "project_id"=>408314, "opened_on"=>0, "closed_on"=>nil, "budget"=>10.0, "billable"=>true}, {"id"=>2162942, "name"=>"TestClient-TestProject-TestTask2", "position"=>2, "project_id"=>408314, "opened_on"=>1, "closed_on"=>nil, "budget"=>90.0, "billable"=>true}, {"id"=>2162943, "name"=>"TestClient-TestProject-TestTask3", "position"=>3, "project_id"=>408314, "opened_on"=>3, "closed_on"=>nil, "budget"=>0.0, "billable"=>true}]}
        @ts.stub(:request).and_return(h)

        @ts.tasks(project_id: 2162941).should eq h['tasks']
      end

    end
  end
end
