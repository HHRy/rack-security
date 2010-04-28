class AttackFilter

  # Overloaded by children, kept here for simple testing
  #
  ATTACK_PATTERNS = [ /IAMANATTACK/ ]

  def initialize(value)
    if [Hash,String].include?(value.class)
      @value = value
    else
      raise "Can only be initialized with a String or a Hash"
    end
  end

  def sanitize
    if @value.is_a?(Hash)
      walk_through_hash(@value)
    elsif @value.is_a?(String)
      walk_through_string(@value)
    end
  end

  # Walks through a Hash recursively checking for matches against
  # defined ATTACK_PATTERNS. Returns a modified hash with any
  # suspicious values replaced with nil.
  #
  def walk_through_hash(target_hash)
    keys_to_blank = []
    working_hash = target_hash.dup
    working_hash.each do |key, value|
      if value.is_a?(Hash)
        key = walk_through_hash(value)
      else
        self.class::ATTACK_PATTERNS.each do |attack|
          if value =~ attack
            keys_to_blank << key
          end
        end 
      end
    end
    keys_to_blank.each { |k| working_hash[k] = nil  }
    working_hash
  end

  # Like the hash sanitising method, replaces all instances of 
  # matches to an attack pattern with an empty string.
  #
  def walk_through_string(target_string)
    working_string = target_string.dup
    self.class::ATTACK_PATTERNS.each do |attack|
      if working_string =~ attack
        working_string.gsub!(attack,'')
      end
    end
    working_string
  end

end
