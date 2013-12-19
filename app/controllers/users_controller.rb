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
  end

  def me
      @user = current_user
      render :show
  end

  def edit
      @user = current_user
  end

  def update
      @user = current_user
      if @user.update(user_params)
          redirect_to me_path, :notice => 'Updated profile.'
      else
          render :edit
      end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
          r = @user.registrants.build
          r.name = @user.name
          r.save
          session[:user_id] = @user.id
        redirect_to (Qualifier.count > 0 ? qualifiers_path(@user.registrant.first) : @user), :notice => 'Created user.'
      else
        format.html { render action: 'new' }
      end
    end
  end

  def condense
      @user = User.find(params[:id])
      @registrant = @user.registrants.find(params[:registrant_id])
      @user.condense_charges @registrant
      redirect_to @user, :notice => 'Condensed charges.'
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name)
    end
end
