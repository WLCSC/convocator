class EventsController < ApplicationController
  before_filter :check_for_presenter, :only => [:update]
  def index
      @events = Event.order(:start)
  end

  def update
    @event = Event.friendly.find(params[:id])
    @event.description = params[:description]
    @event.save
    redirect_to @event, :notice => "Updated description."
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
