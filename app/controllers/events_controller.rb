class EventsController < ApplicationController
  before_action :load_issue

  def index
    render json: @issue.events
  end

  def create
    @event = Event.new(issue: @issue, action: action_name)
    if @event.save
      render json: @event
    else
      render json: 'Unable to register event.', status: :unprocessable_entity
    end
  end

  private

  # Get action straight from query or request parameters due to name conflict
  # with controller action on params.
  def action_name
     request.query_parameters[:action] ||
      request.request_parameters[:action]
  end

  def load_issue
    id = params[:issue_id] || params[:issue][:number]
    @issue = Issue.find_or_create_by(id: id)
  end
end
