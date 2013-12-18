class Registration < ActiveRecord::Base
    belongs_to :registrant
    belongs_to :event
end
