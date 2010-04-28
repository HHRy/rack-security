require File.dirname(__FILE__) + '/test_helper.rb'

class SqlInjectionFilterTest < Test::Unit::TestCase
  
  def test_filter_is_a_child_of_attack_filter
    assert SqlInjectionFilter.new('').is_a?(AttackFilter)
  end

  def test_sql_filter_defines_different_attack_paterns
    assert_not_equal AttackFilter::ATTACK_PATTERNS, SqlInjectionFilter::ATTACK_PATTERNS
  end

  def test_filters_union_attack_in_hashes
    input = { :attack => "'union SELECT foo", :valid => "cheese" }
    output = { :attack => nil, :valid => "cheese" }
    assert_equal output, SqlInjectionFilter.new(input).sanitize
  end

  def test_filters_always_true_attack_in_hashes
    input = {:username => "' OR '1' = '1'", :password => 'doesnt_matter'}
    output = {:username => nil, :password => 'doesnt_matter'}
    assert_equal output, SqlInjectionFilter.new(input).sanitize
    input = {:username => "' OR 1=1;", :password => 'doesnt_matter'}
    output = {:username => nil, :password => 'doesnt_matter'}
    assert_equal output, SqlInjectionFilter.new(input).sanitize
  end

  def test_filters_union_attack_in_strings
    input = "'union SELECT foo"
    output = ' SELECT foo'
    assert_equal output, SqlInjectionFilter.new(input).sanitize
  end

  def test_filters_always_true_attack_in_strings
    input =  "' OR '1' = '1'"
    output = "' OR '1' "
    assert_equal output, SqlInjectionFilter.new(input).sanitize
    input = "' OR 1=1;"
    output = "' OR 1"
    assert_equal output, SqlInjectionFilter.new(input).sanitize
  end

end
