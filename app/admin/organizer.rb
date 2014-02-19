ActiveAdmin.register Organizer do

    index do
        column :photo do |o|
            image_tag o.photo.url(:thumb), :width => "80"
        end
        column :name do |o|
            link_to(o.name, admin_organizer_path(o)) + (o.public ? '' : '<br/><i>(Hidden)</i>').html_safe
        end
        column :description do |o|
            markdown o.description
        end
        actions
    end

    form do |f|
        f.inputs do
            f.input :name
            f.input :public
            f.input :description
            f.input :photo, :as => :file
        end
        f.actions
    end

    action_item :only => :show do
        link_to 'User', admin_user_path(organizer.user)
    end

    before_filter :only => [:show, :edit, :destroy, :update] do
        @organizer = Organizer.friendly.find(params[:id])
    end

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :description, :public, :photo
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
