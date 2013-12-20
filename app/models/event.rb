class Event < ActiveRecord::Base
    extend FriendlyId
    include Metahash
    has_many :taggings
    has_many :tags, :through => :taggings
    has_many :assignments
    has_many :presenters, :through => :assignments
    has_many :provisions
    has_many :resources, :through => :provisions
    has_many :registrations
    has_many :registrants, :through => :registrations
    has_many :charges, :as => :charger
    has_many :rulers
    has_many :rules, :through => :rulers

    friendly_id :name, use: :slugged
    has_attached_file :photo, :styles => {:medium => "300x300>", :thumb => '100x100>'}
    accepts_nested_attributes_for :rules, :allow_destroy => true

    def allows? registrant 
        go = true

        registrant.events.each do |e|
            if e.end >= self.start && e.start <= self.end
                go = false
            end
        end

        self.rules.where(:group_id => registrant.group_ids << nil).each do |rule|
            rule.meta.each do |k, v|
                case k
                when 'block'
                    go = false
                end
            end
        end
        go
    end

    def unregister_rules registrant 
        go = true
        continue_condition = true
        self.rules.where(:group_id => registrant.group_ids << nil).each do |rule|
            rule.meta.each do |k, v|
                if continue_condition
                    puts "Processing #{k} - #{v}"
                    params = v.split '&'
                    case k
                    when 'and'
                        group = Group.where(:slug => params[0])
                        continue_condition = false unless  group.count > 0 && group.first.registrants.include?(registrant)
                    when 'norefundafter'
                        if DateTime.now < DateTime.parse(params[3])
                        @charge = registrant.charges.build
                        @charge.charger = rule
                        @charge.amount = -BigDecimal.new(params[0])
                        @charge.comment = "Canceled " + params[1] + " [#{name}]"
                        @charge.description = ''
                        @charge.icon = params[2] || 'usd'
                        @charge.save
                        end
                    when 'charge'
                        @charge = registrant.charges.build
                        @charge.charger = rule
                        @charge.amount = -BigDecimal.new(params[0])
                        @charge.comment = "Canceled " + params[1] + " [#{name}]"
                        @charge.description = ''
                        @charge.icon = params[2] || 'usd'
                        @charge.save
                    when 'block'
                        go = false
                    end
                end
            end
        end
        go
    end


    def register_rules registrant 
        go = true
        continue_condition = true
        self.rules.where(:group_id => registrant.group_ids << nil).each do |rule|
            rule.meta.each do |k, v|
                if continue_condition
                    puts "Processing #{k} - #{v}"
                    params = v.split '&'
                    case k
                    when 'and'
                        group = Group.where(:slug => params[0])
                        continue_condition = false unless  group.count > 0 && group.first.registrants.include?(registrant)
                    when 'charge'
                        @charge = registrant.charges.build
                        @charge.charger = rule
                        @charge.amount = BigDecimal.new(params[0])
                        @charge.comment = params[1] + " [#{name}]"
                        @charge.description = ''
                        @charge.icon = params[2] || 'usd'
                        @charge.save
                    when 'norefundafter'
                        @charge = registrant.charges.build
                        @charge.charger = rule
                        @charge.amount = BigDecimal.new(params[0])
                        @charge.comment = params[1] + " [#{name}]"
                        @charge.description = ''
                        @charge.icon = params[2] || 'usd'
                        @charge.save
                    when 'norefund'
                        @charge = registrant.charges.build
                        @charge.charger = rule
                        @charge.amount = BigDecimal.new(params[0])
                        @charge.comment = params[1] + " [#{name}]"
                        @charge.description = ''
                        @charge.icon = params[2] || 'usd'
                        @charge.save
                    when 'block'
                        go = false
                    end
                end
            end
        end
        go
    end

    def allows registrant
        allows? registrant
    end

    def registrants_for user
        registrants.where(:user_id => user.id)
    end
end
