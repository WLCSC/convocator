ActiveAdmin.register Rule do
 
    form do |f|
        f.inputs do
            f.input :group
            f.input :meta_string, :as => :text, :input_html => {:value => rule.get_meta_string}
        end
        
        f.inputs 'Events' do
            f.input :events, :as => :check_boxes, :collection => Event.all
        end

        f.actions
    end
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :group_id, :meta_string, :event_ids => []
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
