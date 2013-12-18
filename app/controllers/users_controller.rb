class UsersController < ApplicationController
    before_action :check_for_user, :only => [:me]

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
      if @user.update(params[:user])
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
          session[:user_id] = @user.id
        format.html { redirect_to root_path, notice: 'Welcome!' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
