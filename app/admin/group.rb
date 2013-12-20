ActiveAdmin.register Group do

    form do |f|
        f.inputs do
            f.input :parent
            f.input :name
            f.input :approvable
            f.input :joinable
        end

        f.actions
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
