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
      if (current_presenter && @event.presenters.include?(current_presenter)) || current_organizer
          @users = @event.registrants.map{|r| r.user}.uniq
      end
  end

  def tagged
  end

  def charge
      @event = Event.friendly.find(params[:id])
      if (current_presenter && @event.presenters.include?(current_presenter)) || current_organizer
          if params[:amount].empty? || params[:comment].empty? || params[:description].empty? || params[:icon].empty?
              redirect_to @event, alert: "Fill out all the fields before charging."
          else
              @event.registrations.where(:waiting => nil).each do |r|
                reg = r.registrant
                charge = reg.charges.build
                charge.charger_type = (current_organizer ? "Organizer" : "Presenter")
                charge.charger_id = (current_organizer ? current_organizer.id : current_presenter.id)
                charge.amount = params[:amount]
                charge.comment = @event.name + " - " + params[:comment]
                charge.description = params[:description]
                charge.icon = params[:icon]
                charge.save
              end
              redirect_to @event, notice: "Charged enrolled registrants."
          end
      end  
  end
end
