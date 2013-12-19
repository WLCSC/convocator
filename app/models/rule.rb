class Rule < ActiveRecord::Base
    include Metahash
    belongs_to :group
    has_many :rulers
    has_many :events, :through => :rulers

end
