class Membership < ActiveRecord::Base
    belongs_to :group
    belongs_to :registrant

    before_create :set_approved

    def set_approved
      if approved == nil
      if self.group.approvable
        self.approved = false
      else
        self.approved = true
      end
      end
      true
    end
end
