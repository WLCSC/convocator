class Organizer < ActiveRecord::Base
    has_many :charges, :as => :charger
    belongs_to :user


    has_attached_file :photo, :styles => {:medium => "300x300>", :thumb => '100x100>'}
end
