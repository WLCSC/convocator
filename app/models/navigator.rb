class Navigator < ActiveRecord::Base
    include Metahash
    belongs_to :page
    has_many :children, :class_name => 'Navigator', :foreign_key => 'parent_id'
    belongs_to :parent, :class_name => 'Navigator'

    def meta_string
        s = ""
        meta.each do |k,v|
            s << "#{k}:#{v}\n"
        end
        s
    end

end
