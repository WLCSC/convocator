ActiveAdmin.register Registrant do

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
