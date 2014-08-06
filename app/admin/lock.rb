ActiveAdmin.register Lock do

    member_action :toggle do
        lock = Lock.find(params[:id])
        lock.locked = !lock.locked
        lock.save
        redirect_to admin_lock_path(lock)
    end

    action_item only: :show do
        link_to "Toggle", "#{lock.id}/toggle"
    end
  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :locked
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
