class Resource < ActiveRecord::Base
    has_many :provisions
    has_many :events, :through => :provisions
end
