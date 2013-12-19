class Presenter < ActiveRecord::Base
    extend FriendlyId
    has_many :revisions
    has_many :assignments
    has_many :events, :through => :assignments
    belongs_to :user

    has_attached_file :photo, :styles => {:medium => "300x300>", :thumb => '100x100>'}
    friendly_id :name, use: :slugged
end
