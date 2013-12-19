class Qualifier < ActiveRecord::Base
    include Metahash
    belongs_to :group

    def qualify user, response
       case meta['type']
       when 'check_box'
           response ? true : false
       end
    end
end
