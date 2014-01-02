ActiveAdmin.register Rule do

  index do
    column :id
    column :group
    column :qualifiers do |r|
      r.get_qualifiers_string.strip.gsub("\n", ' - ')
    end

    column :actions do |r|
      r.get_meta_string.strip.gsub("\n", ' - ')
    end
    column :events do |r|
      r.events.map{|e| link_to(e.name, admin_event_path(e))}.join(', ').html_safe
    end

    actions
  end
 
    form do |f|
        f.inputs do
            f.input :group
            f.input :qualifiers_string, :as => :text, :input_html => {:value => rule.get_qualifiers_string}
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
  permit_params :group_id, :meta_string, :qualifiers_string, :event_ids => []
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
