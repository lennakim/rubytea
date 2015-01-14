class EventsController < ApplicationController
  def index
    @events = Event.recent.page(params[:page])
  end

  def show
    @event = Event.find(params[:id])
  end
end
