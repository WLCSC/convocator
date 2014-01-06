ActiveAdmin.register Event do

    index do
        column :name do |e|
            ("<i class=\"fa fa-#{e.icon}\"></i> " +  link_to(e.name, admin_event_path(e))).html_safe
        end
        column :cost do |e|
            number_to_currency e.cost
        end
        column :enrollment do |e|
          e.registrations.where(:waiting => nil).count
        end
        column :waiting do |e|
          e.waitable ? e.registrations.where(:waiting => true).count : '---'
        end
        column :limit
        column :start
        column :end
    end

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
