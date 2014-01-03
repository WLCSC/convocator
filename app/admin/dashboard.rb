ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => 'Dashboard' 

  page_action :unlock, :method => :get do
    Option.where(:key => 'lock-registration').first.update_attributes(:value => 'unlock')
    redirect_to admin_dashboard_path
  end
  page_action :lock, :method => :get do
    Option.where(:key => 'lock-registration').first.update_attributes(:value => 'lock')
    redirect_to admin_dashboard_path
  end

  content do
    columns do
    column do
      panel "Lock/Unlock Registration" do
        if Option.where(:key => 'lock-registration').first.value == 'lock'
          link_to "Unlock", admin_dashboard_unlock_path
        else
          link_to "Lock", admin_dashboard_lock_path
        end
      end
      panel "Recent Registrations" do
        table_for Registration.order('created_at DESC').first(10) do
          column 'Registrant' do  |r|
            link_to r.registrant.name, admin_registrant_path(r.registrant)
          end
          column 'User' do |r|
            link_to r.registrant.user.email, admin_user_path(r.registrant.user)
          end
          column 'Event' do |r|
            link_to ("<i class=\"fa fa-#{r.event.icon}\"> " + r.event.name).html_safe, admin_event_path(r.event)
          end
          column 'Registered At' do |r|
            r.created_at.strftime("%Y-%m-%d %I:%M %P")
          end
        end
      end
    end

    column do
      panel "Outstanding Money" do
        para number_to_currency(User.all.map{|u| u.balance}.inject(0, :+))

        table_for User.all.delete_if{|u| u.balance == 0 } do
          column 'Email' do |u|
            link_to u.email, admin_user_path(u)
          end
          column 'Registrants' do |u|
            u.registrants.map{|r| link_to r.name, admin_registrant_path(r)}.join(', ').html_safe
          end
          column 'Balance' do |u|
            link_to number_to_currency(u.balance), bill_user_path(u)
          end
        end
      end
    end
    end
  end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
    # content
end
