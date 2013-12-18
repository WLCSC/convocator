ActiveAdmin.register User do

    form do |f|
        f.inputs do
            f.input :email
            f.input :password
            f.input :password_confirmation
        end

        f.actions
    end

    member_action :create_presenter do
        user = User.find(params[:id])
        if user.presenter
            redirect_to admin_presenter_path(user.presenter)
        else
            p = Presenter.create(:user_id => user.id)
            redirect_to admin_presenter_edit_path(p)
        end
    end

    member_action :create_organizer do
        user = User.find(params[:id])
        if user.organizer
            redirect_to admin_organizer_path(user.organizer)
        else
            p = Organizer.create(:user_id => user.id)
            redirect_to admin_organizer_edit_path(p)
        end
    end

    action_item :only => :show do
        link_to('Organizer', "#{user.id}/create_organizer")
    end
  
    action_item :only => :show do
        link_to('Presenter', "#{user.id}/create_presenter")
    end
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :email, :password, :password_confirmation
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
