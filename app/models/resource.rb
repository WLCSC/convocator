class Resource < ActiveRecord::Base
    include Metahash
    has_many :provisions
    has_many :events, :through => :provisions

    def meta_string
        s = ""
        meta.each do |k,v|
            s << "#{k}:#{v}\n"
        end
        s
    end

end
