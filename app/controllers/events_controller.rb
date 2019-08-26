class EventsController < ApplicationController
  before_action :load_issue
  before_action :load_action, only: [:create]

  def index
    render json: @issue.events
  end

  def create
    @event = Event.new(issue: @issue, action: @action)
    if @event.save
      render json: @event
    else
      render json: 'Unable to register event.', status: :unprocessable_entity
    end
  end

  private

  def load_issue
    id = params[:issue_id] || (params[:issue] && params[:issue][:number])
    if id.blank?
      render json: 'Unable to find issue without an id.', status: :bad_request
    else
      @issue = Issue.find_or_create_by(id: id)
    end
  end

  # Get action straight from query or request parameters due to name conflict
  # with controller action on params.
  def load_action
    @action = request.query_parameters[:action] ||
      request.request_parameters[:action]

    if @action.blank?
      render json: 'Unable to create event without an action.', status: :bad_request
    end
  end
end
