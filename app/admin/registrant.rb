ActiveAdmin.register Registrant do
    index do
        column :name do |r|
            link_to r.name, admin_registrant_path(r)
        end
        column "Registered by" do |r|
            link_to r.user.email, admin_user_path(r.user)
        end
        column :groups do |r|
            r.groups.map{|e| link_to e.name, admin_group_path(e) }.join(', ').html_safe
        end
        column :events do |r|
            r.events.map{|e| link_to (r.waiting_on?(e) ? e.name + " (waiting)" : e.name), admin_event_path(e) }.join(', ').html_safe
        end
        actions do |r|
            link_to "Billing", user_path(r.user), :class => 'member_link'
        end
    end

    show do
        attributes_table do
            row :name
            row :user do
                link_to registrant.user.email, admin_user_path(registrant.user)
            end
            row :groups do
                registrant.groups.map{|g| link_to(g.name, admin_group_path(g))}.join(', ').html_safe
            end
            row :events do
                registrant.events.map{|e| link_to(e.name, admin_event_path(e))}.join(', ').html_safe
            end
        end
    end

    form do |f|
        f.inputs do
            f.input :user_id, :as => :select, :collection => User.all
            f.input :name
        end
        f.inputs 'Groups' do
            f.input :groups, :as => :check_boxes, :collection => Group.all
        end
        f.actions
    end
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :user_id, :name, :group_ids => []
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
