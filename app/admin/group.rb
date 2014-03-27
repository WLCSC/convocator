ActiveAdmin.register Group do

    index do 
        column :name do |g|
            link_to g.name, admin_group_path(g)
        end

        column :slug do |g|
            g.slug
        end

        column :approvable do |g|
            g.approvable ? "Yes" : "No"
        end

        column :joinable do |g|
            g.joinable ? "Yes" : "No"
        end
    end

    form do |f|
        f.inputs do
            f.input :parent
            f.input :name
            f.input :approvable
            f.input :joinable
        end

        f.actions
    end

    show do
        attributes_table do
            row :name
            row :slug
            row :parent
            row :approvable do
                group.approvable ? "Yes" : "No"
            end
            row :joinable do
                group.joinable ? "Yes" : "No"
            end
            row :members do
                group.registrants.map{|r| link_to r.name, admin_registrant_path(r)}.join(', ').html_safe
            end
        end
    end
  
    before_filter :only => [:show, :edit, :update, :destroy] do
        @group = Group.friendly.find(params[:id])
    end
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :parent_id, :approvable, :joinable
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
