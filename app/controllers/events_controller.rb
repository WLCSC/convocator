class EventsController < ApplicationController
  def index
      @events = Event.all
  end

  def show
      @event = Event.friendly.find(params[:id])
  end

  def tagged
  end
end
