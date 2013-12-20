class User < ActiveRecord::Base
    has_one :presenter
    has_one :organizer
    has_many :registrants
    #has_many :charges, :through => :registrants
    #has_many :registrations, :through => :registrants
    #has_many :events, :through => :registrations
    has_secure_password
    validates :email, uniqueness: true

    attr_accessor :name

    def charges
      Charge.where(:registrant_id => self.registrant_ids).order('created_at DESC')
    end

    def balance
        self.registrants.count > 0 ? self.registrants.map{|c| c.balance || 0}.inject(0, :+) : 0
    end

    def condense_charges target
        b = BigDecimal.new '0'
        registrants.each do |r|
            unless r == target
                b += r.balance
                Charge.create(:charger => nil, :amount => -r.balance, :comment => "Condensing Charges on #{target.name}", :description => nil, :icon => 'exchange', :registrant_id => r.id)
            end
        end
        Charge.create(:charger => nil, :amount => b, :comment => 'Condensed Charges', :description => nil, :icon => 'exchange', :registrant_id => target.id)
    end
end
