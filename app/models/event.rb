class Event < ActiveRecord::Base
    extend FriendlyId
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
end
