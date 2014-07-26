class RegistrationController < ApplicationController
    before_action :check_for_organizer, :only => ['unwait']
    def index
        redirect_to current_user
    end

    def create
        @registrant = current_user.registrants.build
        @registrant.name = params[:name]
        if @registrant.save
            redirect_to (Qualifier.count > 0 ? qualifiers_path(@registrant) : @registrant.user), :notice => 'Created registrant.'
        else
            redirect_to current_user, :alert => "Invalid registrant."
        end
    end

    def show
        @registrant = current_user.registrants.find(params[:id])
    end

    def destroy
        @registrant = (current_organizer ? Registrant : current_user.registrants).find(params[:id])
        user = @registrant.user
        if @registrant.balance == 0 && @registrant.events.count == 0
            @registrant.destroy
            redirect_to user, :notice => 'Deleted registrant.'
        else
            redirect_to user, :alert => 'You cannot remove a registrant with an outstanding balance or current enrollments.'
        end
    end

    def charges
        @registrant = Registrant.find(params[:id])
        @charges = @registrant.charges.order('created_at DESC')
    end

    def qualifiers
        @registrant = Registrant.find(params[:id])
        @registrant.groups = []
        @registrant.save
        @qualifiers = Qualifier.all
    end

    def qualify
        @registrant = Registrant.find(params[:id])
        @qualifiers = Qualifier.all

        @qualifiers.each do |q|
            q.qualify @registrant, params["qu#{q.id}"]
        end
        redirect_to @registrant.user
    end

    def charge
        @registrant = Registrant.find(params[:id])
        @charge = @registrant.charges.build
        @charge.charger_type = 'Organizer'
        @charge.charger_id = current_organizer.id
        @charge.amount = params[:amount]
        @charge.comment = params[:comment]
        @charge.description = params[:description]
        @charge.icon = params[:icon]
        if @charge.save
            redirect_to registrant_charges_path(@registrant), :notice => 'Charge posted.'
        else
            redirect_to registrant_charges_path(@registrant), :alert => 'Charge unsucessful.'
        end
    end

    def register
        @registrant = Registrant.find(params[:registrant_id])
        @event = Event.find(params[:event_id])

        if @event.allows? @registrant
            if @event.limit == nil || @event.registrants.count < @event.limit || @event.waitable
                r = Registration.create(:registrant_id => @registrant.id, :event_id => @event.id)

                if @event.limit != nil && @event.waitable && @event.registrants.count > @event.limit  
                    r.waiting = true
                    r.save
                end

                messages = @event.register_rules @registrant

                if @event.cost != 0 && !r.waiting
                    @charge = @registrant.charges.build()
                    @charge.charger = @event
                    @charge.amount = @event.cost
                    @charge.comment = "Registered for #{@event.name}"
                    @charge.description = ''
                    @charge.icon = @event.icon || 'ticket'
                    @charge.save
                end

                if r.waiting
                    redirect_to events_path, :notice => "#{@registrant.name} is on the waitlist for #{@event.name}!"
                else
                    redirect_to events_path, :notice => "Registered #{@registrant.name} for #{@event.name}!"
                end

            else
                redirect_to event_path(@event), :alert => "#{@event.name} is full."
            end

        else
            redirect_to event_path(@event), :alert => "#{@registrant.name} is not allowed to register for that."
        end
    end

    def unregister
        @registrant = Registrant.find(params[:registrant_id])
        @event = Event.find(params[:event_id])

        if @event.registrants.include? @registrant
            r = Registration.where(:event_id => @event.id, :registrant_id => @registrant.id).first
            unless r.waiting
                if @event.cost != 0 || @event.cost != nil
                    @charge = @registrant.charges.build()
                    @charge.charger = @event
                    @charge.amount = -@event.cost
                    @charge.comment = "Canceled registration for #{@event.name}"
                    @charge.description = ''
                    @charge.icon = @event.icon || 'ticket'
                    @charge.save
                end
            end
            @event.unregister_rules @registrant

            r.delete

            if option('auto-waitlist-promote') == 'promote'
                if @event.registrations.where(:waiting => true).count > 0 && @event.registrations.count < @event.limit
                    promote = @event.registrations.where(:waiting => true).order('created_at ASC').first
                    promote.waiting = false
                    promote.save
                    if @event.cost != 0 && !r.waiting
                        @charge = promote.registrant.charges.build()
                        @charge.charger = @event
                        @charge.amount = @event.cost
                        @charge.comment = "Registered for #{@event.name}"
                        @charge.description = 'Promoted off waitlist.'
                        @charge.icon = @event.icon || 'ticket'
                        @charge.save
                    end
                end
            end

            redirect_to @registrant.user, :notice => "Unregistered #{@registrant.name} from #{@event.name}!"
        else
            redirect_to event_path(@event), :alert => "#{@registrant.name} is not registered for that event."
        end

    end

    def unwait
        @registration = Registration.find(params[:id])
        if @registration.event.registrations.where(:waiting => nil).count > @registration.event.limit
            redirect_to @registration.event, :notice => 'There isn\'t room to do that.'
        else
            @registration.waiting = nil
            @registration.save
            redirect_to @registration.event, :notice => 'Moved user off of waitlist.'
        end
    end

    def kick
        @registration = Registration.find(params[:id])
        if current_organizer || (current_presenter && @registration.event.presenters.include?(current_presenter))
            @user = @registration.registrant.user
            @registration.destroy
            redirect_to @user, :notice => 'Kicked registrant out.'
        else
            redirect_to root_path, :alert => 'You can\'t do that.'
        end
    end
end
