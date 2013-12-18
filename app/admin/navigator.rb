ActiveAdmin.register Navigator do

    index as: :block do |nav|
        div for: nav do
            h2 link_to(nav.name, admin_navigator_path(nav))
            nav.children.each do |c|
                link_to c.name, admin_navigator_path(c)
            end
        end
    end

    form do |f|
        f.inputs do
            f.input :name
            f.input :page_id, :as => 'select', :collection => Page.all
            f.input :parent_id, :as => 'select', :collection => Navigator.where(:parent_id => nil)
        end

        f.actions
    end

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :parent_id, :page_id
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
