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
    belongs_to :lock

    friendly_id :name, use: :slugged
    has_attached_file :photo, :styles => {:medium => "300x300>", :thumb => '100x100>'}
    accepts_nested_attributes_for :rules, :allow_destroy => true

    def allows? registrant 
        go = true
        puts "*"*40
        puts "Checking #{registrant.name} for #{self.name}".center(40)

        registrant.events.each do |e|
            if e.end >= self.start && e.start <= self.end
                go = false
                puts "Blocked by Conflict"
            end
        end

        if registrant.user.presenter && (registrant.user.presenter.name == registrant.name)
            registrant.user.presenter.events.each do |e|
                if e.end >= self.start && e.start <= self.end && e != self
                    go = false
                    puts "Blocked by presentation"
                end
            end
        end

        self.rules.where(:group_id => registrant.group_ids << nil).each do |rule|
          allow = rule.allows? registrant
          if allow == true
            go &&= true
            puts "Allowed by R#{rule.id}."
          elsif allow == nil
            puts "R#{rule.id} does not apply."
          else
            go = false
            puts "Blocked by R#{rule.id}."
          end
        end
        puts go ? "OK" : "BLOCKED"
        puts '*'*40
        go
    end

    def unregister_rules registrant 
      self.rules.where(:group_id => registrant.group_ids << nil).each do |rule|
        rule.apply registrant, self
      end
    end


    def register_rules registrant 
      self.rules.where(:group_id => registrant.group_ids << nil).each do |rule|
        rule.apply registrant, self
      end
    end

    def allows registrant
        allows? registrant
    end

    def registrants_for user
        registrants.where(:user_id => user.id)
    end

    def locked?
        lock ? lock.locked : false
    end
end
