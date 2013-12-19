class RegistrationController < ApplicationController
  def index
    @registrants = current_user.registrants
  end

  def create
    @registrant = current_user.registrants.build
    @registrant.name = params[:name]
    @registrant.save

    redirect_to registration_path, :notice => 'Created registrant.'
  end

  def show
    @registrant = current_user.registrants.find(params[:id])
  end

  def destroy
    @registrant = current_user.registrants.find(params[:id])
    if @registrant.balance == 0
      @registrant.destroy
      redirect_to registration_path, :notice => 'Deleted registration.'
    else
      redirect_to registrant_path(@registrant), :alert => 'You cannot remove a registrant with an outstanding balance.'
    end
  end

  def charges
    @registrant = Registrant.find(params[:id])
    @charges = @registrant.charges.order('created_at DESC')
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
end
