class Presenter < ActiveRecord::Base
    has_many :revisions
    has_many :assignments
    has_many :events, :through => :assignments
    belongs_to :user

    has_attached_file :photo, :styles => {:medium => "300x300>", :thumb => '100x100>'}
end
