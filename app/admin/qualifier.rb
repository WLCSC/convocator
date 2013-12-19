ActiveAdmin.register Qualifier do

    form do |f|
        f.inputs do
            f.input :group_id, :as => :select, :collection => Group.all
            f.input :name
            f.input :description
            f.input :meta_string, :as => :text, :input_html => {:value => qualifier.get_meta_string}
        end

        f.actions
    end
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :group_id, :name, :description, :meta_string
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
