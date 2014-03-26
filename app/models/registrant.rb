class Registrant < ActiveRecord::Base
  include Metahash
  has_many :registrations
  has_many :events, :through => :registrations
  belongs_to :user
  has_many :charges
  has_many :memberships
  has_many :groups, :through => :memberships

  def balance
    self.charges.count > 0 ? self.charges.map{|c| c.amount || 0}.inject(0, :+) : 0
  end

  def waiting_on? event
      registrations.where(:event_id => event.id).first.waiting
  end

  def name_with_groups
      if groups.count > 0
          self.name + " (" + groups.map{|g| g.name}.join(', ') + ")"
      else
          self.name
      end
  end
end
