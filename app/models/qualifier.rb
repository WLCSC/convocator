class Qualifier < ActiveRecord::Base
    include Metahash
    belongs_to :group

    def qualify user, response
       case meta['type']
       when 'check_box'
           group.registrants << user if response
       when 'not_check_box'
           group.registrants << user unless response
       when 'switch_box'
           if response
               Group.where(:slug => meta['checked']).first.registrants << user
           else
               Group.where(:slug => meta['unchecked']).first.registrants << user
           end
       when 'radio_group'
            g = Group.where(:slug => meta['values'].split('&')[response.to_i - 1])
            puts meta['values']
            if g.count > 0
                puts "!!!@#{g.name}"
                g.first.registrants << user
            end
    
       end
    end
end
