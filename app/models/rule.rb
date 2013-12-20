class Rule < ActiveRecord::Base
    include Metahash
    belongs_to :group
    has_many :rulers
    has_many :events, :through => :rulers

    def icon
        if meta['icon']
            meta['icon']
        else
            'desktop'
        end
    end

    def name
        'System'
    end
end
