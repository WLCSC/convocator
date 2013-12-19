class Page < ActiveRecord::Base
    extend FriendlyId
    include Metahash

    has_many :navigators

    friendly_id :name, use: :slugged
end
