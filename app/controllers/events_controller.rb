class EventsController < ApplicationController
  def index
      @events = Event.all
  end

  def show
      @event = Event.friendly.find(params[:id])
      if current_presenter || current_organizer
          @users = @event.registrants.map{|r| r.user}.uniq
      end
  end

  def tagged
  end
end
