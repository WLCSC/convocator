ActiveAdmin.register User do

  index do
    column :email do |u|
      link_to u.email, admin_user_path(u)
    end

    column :organizer do |u|
      u.organizer ? link_to(u.organizer.name, admin_organizer_path(u.organizer)) : "Nope"
    end

    column :presenter do |u|
      u.presenter ? link_to(u.presenter.name, admin_presenter_path(u.presenter)) : "Nope"
    end

    column :balance do |u|
      number_to_currency u.balance
    end
  end

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
            redirect_to admin_presenter_path(p)
        end
    end

    member_action :create_organizer do
        user = User.find(params[:id])
        if user.organizer
            redirect_to admin_organizer_path(user.organizer)
        else
            p = Organizer.create(:user_id => user.id)
            redirect_to admin_organizer_path(p)
        end
    end

    action_item :only => :show do
      if user.organizer
        link_to('Organizer', "#{user.id}/create_organizer")
      else
        link_to('Promote to Organizer', "#{user.id}/create_organizer")
      end
    end
  
    action_item :only => :show do
      if user.presenter
        link_to('Presenter', "#{user.id}/create_presenter")
      else
        link_to('Promote to Presenter', "#{user.id}/create_presenter")
      end
    end

    action_item :only => :show do
      link_to('Billing', user_path(user))
    end
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :email, :password, :password_confirmation, :group_ids => []
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
