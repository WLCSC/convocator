class Page < ActiveRecord::Base
    extend FriendlyId
    has_many :navigators

    friendly_id :name, use: :slugged
end
