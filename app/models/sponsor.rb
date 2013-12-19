class Sponsor < ActiveRecord::Base
    include Metahash

    def meta_string
        s = ""
        meta.each do |k,v|
            s << "#{k}:#{v}\n"
        end
        s
    end

end
