class Charge < ActiveRecord::Base
    belongs_to :registrant
    belongs_to :charger, :polymorphic => true
end
