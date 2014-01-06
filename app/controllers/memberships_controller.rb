class MembershipsController < ApplicationController
  before_action :check_for_organizer
  def create
    @registrant = Registrant.find(params[:registrant_id])
    @group = Group.find(params[:group_id])
    Membership.create(:registrant => @registrant, :group => @group)
    redirect_to @registrant.user, :notice => "Added #{@registrant.name} to group."
  end

  def approve
    @membership = Membership.find(params[:id])
    @membership.approved = true
    @membership.save
    redirect_to @membership.registrant.user, :notice => "Approved membership."
  end

  def destroy
    @membership = Membership.find(params[:id])
    redirect_to @membership.registrant.user, :notice => "Removed #{@membership.registrant.name} from group."
    @membership.delete
  end
end
