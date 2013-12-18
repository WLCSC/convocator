class User < ActiveRecord::Base
    has_one :presenter
    has_one :organizer
    has_many :registrants
    #has_many :charges, :through => :registrants
    #has_many :registrations, :through => :registrants
    #has_many :events, :through => :registrations
    has_secure_password
    validates :email, uniqueness: true
end
