require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:issue) { Issue.create! }

  def parsed_response
    @parsed_response ||= JSON.parse(response.body)
  end

  describe "GET #index" do
    it "list events" do
      another_issues = Issue.create!
      e1 = Event.create!(issue: issue, action: 'open')
      e2 = Event.create!(issue: issue, action: 'close')
      e3 = Event.create!(issue: another_issues, action: 'close')

      get :index, params: { issue_id: issue.id }

      ids = parsed_response.map { |event| event['id'].to_i }
      expect(response).to have_http_status(:success)
      expect(ids).to include(e1.id)
      expect(ids).to include(e2.id)
      expect(ids).to_not include(e3.id)
    end

    it 'warns about missing issue' do
      get :index, params: { issue_id: '' }
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe "GET #create" do
    it "creates a new event on existing issue" do
      action_name = 'open'

      get :create, params: { issue: {number: issue.id}, action: action_name }

      expect(response).to have_http_status(:success)
      expect(parsed_response['issue_id']).to eql(issue.id)
      expect(parsed_response['action']).to eql(action_name)
    end

    it "creates a new event and a new issue" do
      number = 999
      action_name = 'open'

      get :create, params: { issue: {number: number}, action: action_name }

      expect(response).to have_http_status(:success)
      expect(parsed_response['issue_id']).to eql(number)
      expect(parsed_response['action']).to eql(action_name)
      expect(Issue.find_by_id(number)).to_not be_nil
    end

    it 'warns about missing issue' do
      action_name = 'open'
      get :create, params: { action: action_name }
      expect(response).to have_http_status(:bad_request)
    end

    it 'warns about missing action' do
      number = 999
      get :create, params: { issue: {number: number} }
      expect(response).to have_http_status(:bad_request)
    end
  end
end
