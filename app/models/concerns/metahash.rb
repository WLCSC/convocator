module Metahash 
    extend ActiveSupport::Concern

    included do
        attr_accessor :meta_string
        serialize :meta, Hash
        before_save :fix_meta
    end

    def fix_meta
        if meta_string
            meta_string.lines.each do |f|
                if f.match(/:/)
                l = f.split ':'
                meta[l[0]] = l[1].strip
                end
            end
        end
    end

    def get_meta_string
        s = ""
        meta.each do |k,v|
            s << "#{k}:#{v}\n"
        end
        s
    end
end
