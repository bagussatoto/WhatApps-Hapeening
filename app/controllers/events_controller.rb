class EventsController < ApplicationController
  def index
    @events = Event.current
  end
end
