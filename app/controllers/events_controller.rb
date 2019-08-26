class EventsController < ApplicationController
  before_action :load_issue

  def index
    render json: @issue.events
  end

  def create
    @event = Event.new(issue: @issue, action: params[:action_name])
    if @event.save
      render json: @event
    else
      render json: 'Unable to register event.', status: :unprocessable_entity
    end
  end

  private

  def load_issue
    id = params[:issue_id] || params[:number]
    @issue = Issue.find_or_create_by(id: id)
  end
end
