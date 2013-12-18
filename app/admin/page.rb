ActiveAdmin.register Page do

    index :as => :grid do |page|
        link_to page.name, admin_page_path(page)
    end

    before_filter :only => [:show, :edit, :destroy] do
        @page = Page.friendly.find(params[:id])
    end

    form do |f|
        f.inputs do
            f.input :name
            f.input :body
        end

        f.actions
    end
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :body
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
