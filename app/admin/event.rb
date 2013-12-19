ActiveAdmin.register Event do

    form do |f|
        f.inputs do
        f.input :name
        f.input :description
        f.input :start
        f.input :end
        f.input :limit
        f.input :cost
        f.input :icon
        f.input :photo
        f.input :waitable
        f.input :meta_string, :as => :text, :input_html => {:value => event.get_meta_string}
        end

        f.inputs "Presenters" do
          f.input :presenters, :as => :check_boxes, :collection => Presenter.all 
        end

        f.actions
    end

    before_filter :only => [:show, :edit, :update, :destroy] do
        @event = Event.friendly.find(params[:id])
    end
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
    permit_params :name, :description, :start, :end, :limit, :cost, :waitable, :icon, :photo, :meta_string, :presenter_ids => []
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
