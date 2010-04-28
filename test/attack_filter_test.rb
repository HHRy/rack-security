require File.dirname(__FILE__) + '/test_helper.rb'

class AttackFilterTest < Test::Unit::TestCase

  def test_can_only_be_initialize_with_a_string_or_hash
    assert_nothing_raised do
      lambda { AttackFilter.new('') }.call
    end
    assert_nothing_raised do
      lambda { AttackFilter.new({}) }.call
    end
    assert_raise RuntimeError do
      lambda { AttackFilter.new(Time.now) }.call
    end
  end

  def test_strips_out_attacks_from_hashes
    assert_equal [ /IAMANATTACK/ ], AttackFilter::ATTACK_PATTERNS
    hash = { :test => 'Oh no IAMANATTACK', :test2 => 'But I am Not' }
    expected = { :test => nil, :test2 => 'But I am Not' }
    assert_equal expected, AttackFilter.new(hash).sanitize
  end

  def test_strips_out_attacks_from_strings
    assert_equal [ /IAMANATTACK/ ], AttackFilter::ATTACK_PATTERNS
    string = 'oh no IAMANATTACK!'
    expected = 'oh no !'
    assert_equal expected, AttackFilter.new(string).sanitize
  end

end
