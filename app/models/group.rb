class Group < ActiveRecord::Base
    extend FriendlyId
    has_many :qualifiers
    has_many :rules
    has_many :memberships
    has_many :registrants, :through => :memberships
    has_many :children, :class_name => 'Group', :foreign_key => 'parent_id'
    belongs_to :parent, :class_name => 'Group'

    friendly_id :name, use: :slugged
end
