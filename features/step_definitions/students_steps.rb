Before do
  #allow_any_instance_of(StudentsController).to receive(:index).and_return('[{"id":1,"user_id":null,"name":null,"created_at":"2013-11-14T05:05:10.084Z","updated_at":"2013-11-14T05:05:10.084Z"},{"id":2,"user_id":null,"name":"Steve","created_at":"2013-11-14T05:19:21.873Z","updated_at":"2013-11-23T07:10:06.181Z"}]')
  allow(StudentsController).to receive(:index).and_return('[{"id":1,"user_id":null,"name":null,"created_at":"2013-11-14T05:05:10.084Z","updated_at":"2013-11-14T05:05:10.084Z"},{"id":2,"user_id":null,"name":"Steve","created_at":"2013-11-14T05:19:21.873Z","updated_at":"2013-11-23T07:10:06.181Z"}]'.to_json)
  #@students.push = JSON.parse('{"id":1,"user_id":null,"name":null,"created_at":"2013-11-14T05:05:10.084Z","updated_at":"2013-11-14T05:05:10.084Z"}').to_hash
  #def StudentsController.index
    #render json: '[{"id":1,"user_id":null,"name":null,"created_at":"2013-11-14T05:05:10.084Z","updated_at":"2013-11-14T05:05:10.084Z"},{"id":2,"user_id":null,"name":"Steve","created_at":"2013-11-14T05:19:21.873Z","updated_at":"2013-11-23T07:10:06.181Z"}]', status: :ok
  #end
end

Given(/^A credentialed user$/) do
  visit "http://admin:nimda@localhost:9887/students/"
end

When(/^They visit the students url$/) do
  get "/students/", format: 'json'
end

Then(/^The api service will return a list of all Students$/) do
puts "page.body: "+page.body.inspect
puts "last_response.body: "+last_response.body.inspect
  response = JSON.parse(last_response.body)
puts "response: "+response.inspect
  expect(response).to eq('[{"id":1,"user_id":null,"name":null,"created_at":"2013-11-14T05:05:10.084Z","updated_at":"2013-11-14T05:05:10.084Z"},{"id":2,"user_id":null,"name":"Steve","created_at":"2013-11-14T05:19:21.873Z","updated_at":"2013-11-23T07:10:06.181Z"}]')
  #page.should have_content('[{"id":1,"user_id":null,"name":null,"created_at":"2013-11-14T05:05:10.084Z","updated_at":"2013-11-14T05:05:10.084Z"},{"id":2,"user_id":null,"name":"Steve","created_at":"2013-11-14T05:19:21.873Z","updated_at":"2013-11-23T07:10:06.181Z"}]')
end

