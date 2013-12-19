class Organizer < ActiveRecord::Base
  extend FriendlyId
  include Metahash
    has_many :charges, :as => :charger
    belongs_to :user

    has_attached_file :photo, :styles => {:medium => "300x300>", :thumb => '100x100>'}
    friendly_id :name, use: :slugged
    def meta_string
        s = ""
        meta.each do |k,v|
            s << "#{k}:#{v}\n"
        end
        s
    end

end
