class Rule < ActiveRecord::Base
    belongs_to :group
    has_many :rulers
    has_many :events, :through => :rulers
end
