class Rule < ActiveRecord::Base
  include Metahash
  belongs_to :group
  has_many :rulers
  has_many :events, :through => :rulers

  attr_accessor :qualifiers_string
  serialize :qualifiers, Hash
  before_save :fix_qualifiers

  def icon
    if meta['icon']
      meta['icon']
    else
      'desktop'
    end
  end

  def name
    'System'
  end

  def fix_qualifiers
    if qualifiers_string
      qualifiers.clear
      qualifiers_string.lines.each do |f|
        if f.match /:/
          l = f.split ':'
          qualifiers[l[0]] = l[1].strip
        end
      end
    end
  end

  def get_qualifiers_string
    s = ""
    qualifiers.each do |k, v|
      s << "#{k}:#{v}\n"
    end
    s
  end

  def allows? registrant
    puts " -> Checking R#{self.id}"
    if applies_to? registrant
      puts ' -> Applies.'
      !meta.has_key?('block')
    else
      nil
    end
  end

  def applies_to? registrant
    go = true
    or_trip = false
    or_go = false
    qualifiers.each do |k, v|
      params = v.split '&'
      puts "#{k.upcase} - #{params}"
      case k
      when 'or'
        or_trip = true
        if !or_go
          group = Group.where(:slug => params[0])
          or_go = group.count > 0 && group.first.memberships.where(:approved => true, :registrant => registrant).count > 0
        end
      when 'not'
        group = Group.where(:slug => params[0])
        go &&= group.count > 0 && group.first.memberships.where(:approved => true, :registrant => registrant).count > 0
      when 'block'
        go &&= false
      when 'and'
        group = Group.where(:slug => params[0])
        go &&= group.count > 0 && group.first.memberships.where(:approved => true, :registrant => registrant).count > 0
      when 'maxcount'
          go &&= registrant.events.count >= params[0].to_i
      when 'umeta'
        if params.count == 1
          go &&= (registrant.meta.has_key?(params[0]))
        else
          go &&= (registrant.meta[params[0]] == params[1])
        end
      end
    end
    if or_trip && !or_go
      go &&= false
    end
    go
  end

  def apply registrant, event
    if allows? registrant
      meta.each do |k, v|
        puts "Processing #{k} - #{v}"
        params = v.split '&'
        case k
        when 'charge'
          @charge = registrant.charges.build
          @charge.charger = rule
          @charge.amount = BigDecimal.new(params[0])
          @charge.comment = params[1] + " [#{name}]"
          @charge.description = ''
          @charge.icon = params[2] || 'usd'
          @charge.save
          true
        when 'norefundafter'
          @charge = registrant.charges.build
          @charge.charger = rule
          @charge.amount = BigDecimal.new(params[0])
          @charge.comment = params[1] + " [#{name}]"
          @charge.description = ''
          @charge.icon = params[2] || 'usd'
          @charge.save
          true
        when 'norefund'
          @charge = registrant.charges.build
          @charge.charger = rule
          @charge.amount = BigDecimal.new(params[0])
          @charge.comment = params[1] + " [#{name}]"
          @charge.description = ''
          @charge.icon = params[2] || 'usd'
          @charge.save
          true
        when 'waitlist'
          reg = Registration.where(:event_id => event.id, :registrant_id => registrant.id).first
          reg.waiting = true
          reg.save
          true
        when 'skipwaitlist'
          reg = Registration.where(:event_id => event.id, :registrant_id => registrant.id).first
          reg.waiting = false
          reg.save
          true
        end
      end
    else
      false
    end
  end

  def unapply registrant
    meta.each do |k, v|
      puts "Processing #{k} - #{v}"
      params = v.split '&'
      case k
      when 'norefundafter'
        if DateTime.now < DateTime.parse(params[3])
          @charge = registrant.charges.build
          @charge.charger = rule
          @charge.amount = -BigDecimal.new(params[0])
          @charge.comment = "Canceled " + params[1] + " [#{name}]"
          @charge.description = ''
          @charge.icon = params[2] || 'usd'
          @charge.save
        end
      when 'charge'
        @charge = registrant.charges.build
        @charge.charger = rule
        @charge.amount = -BigDecimal.new(params[0])
        @charge.comment = "Canceled " + params[1] + " [#{name}]"
        @charge.description = ''
        @charge.icon = params[2] || 'usd'
        @charge.save
      end
    end
    true
  end

end
