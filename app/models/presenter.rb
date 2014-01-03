class Presenter < ActiveRecord::Base
    extend FriendlyId
    include Metahash
    has_many :assignments
    has_many :events, :through => :assignments
    belongs_to :user

    has_attached_file :photo, :styles => {:medium => "300x300>", :thumb => '100x100>'}, :default_url => '/default-person.png'
    friendly_id :name, use: :slugged
end
