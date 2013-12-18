class Ruler < ActiveRecord::Base
    belongs_to :rule
    belongs_to :event
end
