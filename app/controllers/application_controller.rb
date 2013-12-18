class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    private
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def current_organizer
        current_user && current_user.organizer ? current_user.organizer : nil
    end

    def current_presenter
        current_user && current_user.presenter ? current_user.presenter : nil
    end

    def check_for_user
        redirect_to root_path, :alert => 'You must be signed in first.' unless current_user
    end

    def check_for_presenter
        redirect_to root_path, :alert => 'You must be a presenter to do that.' unless current_presenter
    end

    def check_for_organizer
        redirect_to root_path, :alert => 'You must be an organizer to do that.' unless current_organizer
    end

    def option key, value=nil
        opt = Option.where(:key => key).first_or_create(:value => nil)
        if value
            opt.value = value if opt.type == opt.value.class.to_s.downcase
            opt.save
        end
        opt.value
    end

    helper_method :current_user
    helper_method :current_organizer
    helper_method :current_presenter
    helper_method :option
end
