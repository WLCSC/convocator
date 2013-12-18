class Membership < ActiveRecord::Base
    belongs_to :group
    belongs_to :registrant
end
