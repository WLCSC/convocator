class Provision < ActiveRecord::Base
    belongs_to :event
    belongs_to :resource
end
