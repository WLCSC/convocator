class Navigator < ActiveRecord::Base
    belongs_to :page
    has_many :children, :class_name => 'Navigator', :foreign_key => 'parent_id'
    belongs_to :parent, :class_name => 'Navigator'
end
