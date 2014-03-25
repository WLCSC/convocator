class UsersController < ApplicationController
    before_action :check_for_user, :except => [:new, :create]
    before_action :check_for_organizer, :only => [:index]

    def index
        @users = User.all
    end

    # GET /users/new
    def new
        @user = User.new
    end

    def show
        @user = User.find(params[:id])
        redirect_to me_path, :notice => "You can't do that." unless current_user == @user || current_organizer
    end

    def me
        @user = current_user
        render :show
    end

    def edit
        @user = params[:id] ? User.find(params[:id]) : current_user
        redirect_to me_path, :notice => "You can't do that." unless current_user == @user || current_organizer
    end

    def update
        @user = params[:id] ? User.find(params[:id]) : current_user
        unless current_user == @user || current_organizer

            redirect_to me_path, :notice => "You can't do that."       
            if @user.update(user_params)
                redirect_to me_path, :notice => 'Updated profile.'
            else
                render :edit
            end
        end
    end

    # POST /users
    # POST /users.json
    def create
        @user = User.new(user_params)

        if @user.save
          if(@user.id == 1)
            Organizer.create(:name => @user.name, :user_id => @user.id)
            flash[:warning] = "Since you're the first user in the system, you get to be an organizer."
          end
          redirect_to me_path, :notice => "Successfully created account." 
        else
            render action: 'new' 
        end
    end

    def condense
        @user = User.find(params[:id])
        redirect_to me_path, :notice => "You can't do that." unless current_user == @user || current_organizer
        @registrant = @user.registrants.find(params[:registrant_id])
        @user.condense_charges @registrant
        redirect_to @user, :notice => 'Condensed charges.'
    end

    def bill
        @user = User.find(params[:id])
        redirect_to me_path, :notice => "You can't do that." unless current_user == @user || current_organizer
        @charges = @user.charges
    end

    private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :name)
    end
end
