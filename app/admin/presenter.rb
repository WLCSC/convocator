ActiveAdmin.register Presenter do

    index do
        column :photo do |o|
            image_tag o.photo.url(:thumb), :width => "80"
        end
        column :name do |o|
            link_to(o.name, admin_presenter_path(o)) + (o.public ? '' : '<br/><i>(Hidden)</i>').html_safe
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
            f.input :meta_string, :as => :text, :input_html => {:value => presenter.get_meta_string}
        end
        f.actions
    end
  
    before_filter :only => [:show, :edit, :destroy, :update] do
        @presenter = Presenter.friendly.find(params[:id])
    end
    action_item :only => :show do
      if presenter.user
        link_to 'User', admin_user_path(presenter.user)
      end
    end
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :description, :public, :photo, :meta_string
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
