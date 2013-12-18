class Assignment < ActiveRecord::Base
    belongs_to :presenter
    belongs_to :event
end
