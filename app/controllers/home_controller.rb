class HomeController < ApplicationController
  def index
    @events = Event.recent.limit(3)
  end
end